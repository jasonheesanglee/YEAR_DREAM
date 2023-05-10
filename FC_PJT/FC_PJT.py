# !pip install numpy
# !pip install pandas
# !pip install matplotlib
# !pip install scipy
# !pip install seaborn

# ------------------------------------------------------------------------

# importing all modules needed

import os
import time
import numpy as np
import pandas as pd
from matplotlib import rc
import matplotlib.pyplot as plt
import matplotlib.font_manager as fm
import re
import glob
import seaborn as sns
import datetime

# ------------------------------------------------------------------------

# Checking fonts

rc('font', family='AppleGothic')
plt.rcParams['axes.unicode_minus'] = False
font_path = fm.findfont('AppleGothic')
if not font_path:
    print('Warning: AppleGothic font not found')
else:
    print("AppleGothic font found at ", font_path)

font_prop = fm.FontProperties(fname=font_path, size=12)

# ------------------------------------------------------------------------

# Creating variables for data paths

dataset = "./dataset/"
GROUPED = dataset + "Grouped/"
FINAL_GROUP = dataset + "Grouped_Final/"

if not os.path.exists(dataset + "Grouped"):
    os.mkdir(dataset + "Grouped")

if not os.path.exists(dataset + "Grouped_Final"):
    os.mkdir(dataset + "Grouped_Final")

# ------------------------------------------------------------------------

# Adding up all file locations into a dictionary.

file_locations = {
    'grouped': GROUPED,
    'group_final' : FINAL_GROUP #,
    # to be added further
}

all_file_locations = {}
for key, value in file_locations.items():
    all_file_locations[key] = glob.glob(value + "*.csv")

'''

type all_file_locations["key"] to call
keys are "grouped", "group_final", etc.; to be added further.

'''

# ------------------------------------------------------------------------

# Local definitions

def clean_course_name(course_name):
    if course_name.startswith("("):
        # Classify the date range to cleanse.
        if "~" in course_name:
            temp = course_name.split("~")[0]
            # Remove open bracket to identify the year value.
            temp = temp.replace("(", "")
            try:
                # if the value before ~ is in year format, remove the whole bracket.
                if datetime.datetime.strptime(temp, "%y%m%d") == True:
                    return course_name.split(")")[1]
                else:
                    return course_name
            except ValueError:
                raise course_name
        else:
            return course_name
    else:
        return course_name

def course_packages(row):
    # Splitting course classifier (: and -) to extract package name
    parts = re.split("[:|-]", row["course_name"])
    # Finding course names without package classifier
    if len(parts) <= 1:
        # [무료강의] as an exception, it makes more sense if we classify itself alone.
        if parts[0].startswith("[무료강의]"):
            return "[무료강의]"
        # Classify all other courses without package classifier into Other.
        return ("Other")
    # Finding course names with package classifier.
    elif len(parts) > 1:
        # Classify [kit] first, as it needs to be separated from other [ ] covered words.
        if parts[0].startswith("[kit]"):
            return "Kit"
        # Removing (( ))
        elif parts[0].startswith("(("):
            return parts[0].split("))")[1]
        # Removing ( )
        elif parts[0].startswith("("):
            return parts[0].split(")")[1]
        # Removing [ ]
        elif parts[0].startswith("["):
            return parts[0].split("]")[1]
        else:
            return parts[0]
    else:
        return parts[0]


# ------------------------------------------------------------------------

# Changing column names from Korean to English

df = pd.read_csv(dataset+'eda-proj-fc-purchase.csv')
df.rename(columns={"거래id":"transaction_id", "유형":"l_type", "고객id":"customer_id","코스ID":"courseID","사이트":"site", "포맷":"l_format", "카테고리":"l_categories", "코스(상품) 이름":"course_name", "거래일자":"transaction_date_time","쿠폰이름":"coupon_name","판매가격":"sold_price","결제수단":"payment_method","실거래금액":"actual_sold_price","쿠폰할인액":"coupon_discount","거래금액":"transaction_amount","환불금액":"refund_amount"}, inplace=True)
df.to_csv(dataset + "rowdata_eng.csv", index=False)

rowdata_eng = pd.read_csv(dataset+"rowdata_eng.csv")

# ------------------------------------------------------------------------

# Converting date_time to date and time.

df = rowdata_eng['transaction_date_time'].str.split(" ", n=5, expand=True)
rowdata_eng['Date'] = df[0].str.cat([df[1], df[2]], sep="")
rowdata_eng['Time'] = df[3].str.cat([df[4]], sep=" ")

# Converting time to 24H format

rowdata_eng["Time"] = rowdata_eng["Time"].str.replace("오후", "PM").str.replace("오전","AM")
rowdata_eng['Time'] = rowdata_eng['Time'].apply(lambda x: datetime.datetime.strptime(x, '%p %I:%M:%S').strftime('%H:%M:%S'))
timedone_data = rowdata_eng
# rowdata_eng.to_csv(dataset + "times.csv", index=False)

# ------------------------------------------------------------------------

# Removing date range in course_name

timedone_data["course_name"] = timedone_data["course_name"].apply(clean_course_name)
course_name_cleansed = timedone_data

# row_time_data.to_csv(dataset +"course_name_cleansed.csv", index = False)

# ------------------------------------------------------------------------

# Grouping courses by Packages

# "The Red" had many variances, needed to cleanse the course_name once again solely for this
course_name_cleansed["course_name"] = course_name_cleansed["course_name"].apply(lambda x: x.replace(" ", "").lower())

# Applying def course_packages.
course_name_cleansed["course_group"] = course_name_cleansed.apply(course_packages, axis=1)

# Generating CSV file for each Package.
grouped_df = course_name_cleansed.groupby("course_group")
for group_name, group_df in grouped_df:
    groupname = group_name.replace("/", "_")
    filename = f"{groupname.strip()}.csv"
    group_df.to_csv(GROUPED + f"{filename}", index=False)

# ------------------------------------------------------------------------

# Some packages only had one course each, needed to re-classify them as others
for file in all_file_locations["grouped"]:
    df = pd.read_csv(file, low_memory=False)
    # print(file, file.split("/")[-1].split(".")[0] ,len(set(df["course_name"])))

df_new = pd.DataFrame()
df_other = pd.read_csv(GROUPED + "Other.csv")
for file in all_file_locations["grouped"]:
    # We don't need to check Other.csv as we want to add more data to it
    if file == GROUPED + "Other.csv":
        continue
    else:
        df = pd.read_csv(file, low_memory=False)
        # Check if any Package has only one course
        if len(set(df["course_name"])) == 1:
            # There is only one course in [무료강의], but as it seemed more legit if we separate it from Others.
            if file == GROUPED + "[무료강의].csv":
                # Adding up [무료강의].csv to final CSV folder
                df.to_csv(FINAL_GROUP + "[무료강의].csv", index=False)
                pass
            else:
                # Add all packages that only has one course to df_new
                df_new = pd.concat([df_new, df])

        else:
            # Adding all the packages with multiple courses to the final CSV folder.
            df = pd.read_csv(file, low_memory=False)
            filetitle = file.split("/")[-1].split(".")[0]
            df.to_csv(FINAL_GROUP + f"{filetitle}.csv", index=False)


df_all = pd.concat([df_new, df_other])
df_all.to_csv(FINAL_GROUP + "Others.csv", index=False)



print("Done")

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
            # if the value before ~ is in year format, remove the whole bracket.
            if len(temp) == 7:
                return course_name.split(")")[1]
            else:
                return course_name
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
            return "[kit]"
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
df.rename(columns={"거래id":"transaction_id", "유형":"l_type", "고객id":"customer_id","코스ID":"courseID","사이트":"site", "포맷":"l_format",
                   "카테고리":"l_categories", "코스(상품) 이름":"course_name", "거래일자":"transaction_date_time","쿠폰이름":"coupon_name",
                   "판매가격":"sold_price","결제수단":"payment_method","실거래금액":"actual_sold_price","쿠폰할인액":"coupon_discount",
                   "거래금액":"transaction_amount","환불금액":"refund_amount"
                   },
          inplace=True)
df.to_csv(dataset + "rowdata_eng.csv", index=False)

# ------------------------------------------------------------------------

rowdata_eng = pd.read_csv(dataset+"rowdata_eng.csv")

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

timedone_data.to_csv(dataset +"course_name_cleansed.csv", index = False)

# ------------------------------------------------------------------------

# Grouping courses by Packages

# "The Red" had many variances, needed to cleanse the course_name once again solely for this
course_name_cleansed["course_name"] = course_name_cleansed["course_name"].apply(lambda x: x.replace(" ", "").lower())

# Applying def course_packages.
course_name_cleansed["course_group"] = course_name_cleansed.apply(course_packages, axis=1)

course_name_cleansed.to_csv(dataset + "package_clarified.csv",index=False)

# Generating CSV file for each Package.
grouped_df = course_name_cleansed.groupby("course_group")
for group_name, group_df in grouped_df:
    groupname = group_name.replace("/", "_")
    filename = f"{groupname.strip()}.csv"
    group_df.to_csv(GROUPED + f"{filename}", index=False)

# ------------------------------------------------------------------------
time.sleep(2)
# ------------------------------------------------------------------------


# Some packages only had one course each, needed to re-classify them as others
for file in all_file_locations["grouped"]:
    df = pd.read_csv(file, low_memory=False)
    # print(file, file.split("/")[-1].split(".")[0] ,len(set(df["course_name"])))

df_new = pd.DataFrame()
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

df_other = pd.read_csv(GROUPED + "Other.csv")
df_all = pd.concat([df_new, df_other])
df_all.to_csv(FINAL_GROUP + "Others.csv", index=False)

# ------------------------------------------------------------------------

total_pck = pd.read_csv(dataset + "package_clarified.csv", encoding="utf-8-sig")

pck_prchsd_usr = total_pck.groupby("course_group")["customer_id"].nunique().rename("pck_purchased_user")
total_prchsd_usr = total_pck.groupby("course_group")["transaction_id"].nunique().rename("total_purchased_user")
comparison_df = pd.concat([pck_prchsd_usr, total_prchsd_usr], axis=1)


# ------------------------------------------------------------------------

fig, ax = plt.subplots()

for file_loc in all_file_locations["group_final"]:
    filename = file_loc.split("/")[-1].split(".")[0]
    if filename == "Others":
        pass
    else:
        file = pd.read_csv(file_loc, encoding="utf-8-sig")
        pck_prchsd_usr = file.groupby("course_group")["customer_id"].nunique().rename("pck_purchased_user")
        ax.bar(pck_prchsd_usr.index, pck_prchsd_usr.values, width=0.8, label=filename[:4])


# Add chart title and axis labels
ax.set_title('Number of Unique Customers per Course Group')
ax.set_xlabel('Course Group')
ax.set_ylabel('Number of Unique Customers')
plt.xticks(alpha=0.5, fontsize=7,rotation=45)
ax.legend().remove()

# Display the chart
# plt.show()

# ------------------------------------------------------------------------

# others_mask = comparison_df["pck_purchased_user"] / comparison_df["pck_purchased_user"].sum() < 0.05
# others_sum = comparison_df.loc[others_mask, "pck_purchased_user"].sum()
# comparison_df = comparison_df[~others_mask]
# comparison_df = comparison_df.append(pd.Series({"pck_purchased_user": others_sum}, name="Others"))

def my_autopct(pct):
    return ('%.3f' % pct) if pct > 5 else ''

compsizes = comparison_df["pck_purchased_user"].values
totalsizes = comparison_df["total_purchased_user"].values
percentages = compsizes / totalsizes
labels = comparison_df.index.values
print(comparison_df)
# print(sum(comparison_df.values))
print(comparison_df.values.sum())
print(labels)

colors = ['blue', 'orange', 'green', 'red', 'skyblue', 'yellow']
fig, ax = plt.subplots()
ax.pie(percentages, labels=labels, colors=colors, autopct=my_autopct, startangle=90, counterclock=False)

ax.tick_params(axis='both', which='both', length=0)
ax.legend().set_visible(False)

plt.title('Proportion of Customers per Course Group')


plt.axis("equal")
plt.show()

print("Done")

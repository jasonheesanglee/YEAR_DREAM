import numpy as np

print("Hello World")

num_list = [i if i <=5 else 10 for i in range(1, 10)]
print(num_list)

print()

index_quiz = np.array(range(30)).reshape([2, 3, 5])
print(index_quiz[:1, 1:, 2])
import statistics
import matplotlib.pyplot as plt


def read_results():
    thresholds = []
    precision_m1_means = []
    recall_m1_means = []
    precision_m2_means = []
    recall_m2_means = []
    with open("./method1/result/result_all.txt") as result_m1, open("./method2/result/result_all.txt") as result_m2:
        lines_m1 = result_m1.readlines()
        for line in lines_m1:
            line_split = line.split(sep=" ")
            if line_split[0] == "#" or line_split[0] == "#\n":
                continue
            thresholds.append(int(line_split[0]))
            precision_m1_str = line_split[1::2]
            precision_m1_str.remove("\n")
            precision_m1 = [float(i) for i in precision_m1_str]
            precision_m1_means.append(statistics.mean(precision_m1))
            recall_m1 = [float(i) for i in line_split[2::2]]
            recall_m1_means.append(statistics.mean(recall_m1))
        lines_m2 = result_m2.readlines()
        for line in lines_m2:
            line_split = line.split(sep=" ")
            if line_split[0] == "#" or line_split[0] == "#\n":
                continue
            precision_m2_str = line_split[1::2]
            precision_m2_str.remove("\n")
            precision_m2 = [float(i) for i in precision_m2_str]
            precision_m2_means.append(statistics.mean(precision_m2))
            recall_m2 = [float(i) for i in line_split[2::2]]
            recall_m2_means.append(statistics.mean(recall_m2))
    
    return thresholds, precision_m1_means, precision_m2_means, recall_m1_means, recall_m2_means


def compare_results():
    means = read_results()
    plt.plot(means[3], means[1])
    plt.plot(means[4], means[2])
    plt.show()
    

if __name__ == "__main__":
    compare_results()

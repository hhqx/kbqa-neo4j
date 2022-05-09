import os
import re
import jieba

from sklearn.naive_bayes import MultinomialNB
from sklearn.feature_extraction.text import TfidfVectorizer


class Question_classify:
    def __init__(self):
        # 读取训练数据
        self.train_x, self.train_y = self.read_train_data()
        # 训练模型
        self.tv = None
        self.model = self.train_model_NB()

    # 获取训练数据
    def read_train_data(self):
        train_x = []
        train_y = []

        for root, dirs, files in os.walk("./data/templates/"):
            file_list = [os.path.join(root, file) for file in files]
        # 遍历所有文件
        for file in file_list:
            # 获取文件名中的数字
            num = re.sub(r"\D", "", file)
            # 如果该文件名有数字，则读取该文件
            if str(num).strip() != "":
                # 读取文件内容
                with (open(file, "r", encoding="utf-8")) as f:
                    for line in f.readlines():
                        word_list = list(jieba.cut(str(line).strip()))
                        # 将这一行加入结果集
                        train_x.append(" ".join(word_list))
                        train_y.append(int(num))
        return train_x, train_y

    def train_model_NB(self):
        X_train, y_train = self.train_x, self.train_y
        self.tv = TfidfVectorizer()

        train_data = self.tv.fit_transform(X_train).toarray()
        clf = MultinomialNB(alpha=0.01)
        clf.fit(train_data, y_train)
        return clf

    def predict(self, question):
        assert self.model, 'Train first...'
        question = [" ".join(list(jieba.cut(question)))]
        test_data = self.tv.transform(question).toarray()
        y_predict = self.model.predict(test_data)[0]
        return y_predict


if __name__ == "__main__":
    qc = Question_classify()
    qc.predict("张学友的个人信息")
    pass

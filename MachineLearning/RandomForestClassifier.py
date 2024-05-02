import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score

data = pd.read_csv('../CSVs/MachineLearningInput.csv')
data = data.astype(str)

X = data[['Plaintiff_Name', 'Defendant_Name', 'State_of_Filing', 'Date_of_Filing', 'Industry', 'Website', 'Keyword_1', 'Keyword_2', 'Keyword_3', 'Keyword_4', 'Keyword_5']]
y = data['Requested_Damages']

# Split the data into training and testing sets
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, train_size=.8, random_state=42)

# Suggestion from ChatGPT: Perform one-hot encoding on categorical variables
X_train_encoded = pd.get_dummies(X_train)
X_test_encoded = pd.get_dummies(X_test)

# Suggestion from ChatGPT: Align feature names in test data with training data
X_test_encoded = X_test_encoded.reindex(columns=X_train_encoded.columns, fill_value=0)

model = RandomForestClassifier(n_estimators=200, random_state=42)
model.fit(X_train_encoded, y_train)

y_pred = model.predict(X_test_encoded)

misclassified_rows = X_test[y_test != y_pred].reset_index(drop=True)
expected_results = y_test[y_test != y_pred].reset_index(drop=True)
predicted_results = y_pred[y_test != y_pred]

misclassified_data = pd.concat([misclassified_rows, expected_results, pd.Series(predicted_results, name='Predicted_Result')], axis=1)
misclassified_data.to_csv('./misclassified_rows.csv', index=False)

print("Misclassified Rows, Actual Result, and Predicted Result:")
for index, row in misclassified_rows.iterrows():
    print("Row:", row)
    print("Actual Result:", expected_results[index])
    print("Predicted Result:", predicted_results[index])
    print()
predicted_right = (y_test == y_pred).sum()
predicted_wrong = len(y_test) - predicted_right

print("Predicted Right:", predicted_right)
print("Predicted Wrong:", predicted_wrong)

accuracy = accuracy_score(y_test, y_pred)
print('Accuracy:', accuracy)

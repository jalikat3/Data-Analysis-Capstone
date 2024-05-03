import pandas as pd

average_df = pd.read_csv('./Results_CSV/PlaintiffAnalysisResult_Averages.csv')

average_of_averages = average_df['AverageTimeInterval'].mean()

print("Average of Averages:", average_of_averages)

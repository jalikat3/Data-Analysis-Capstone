import pandas as pd
import matplotlib.pyplot as plt

average_df = pd.read_csv('../CSVs/PlaintiffAnalysisResult_Averages.csv')
smallest_df = pd.read_csv('../CSVs/PlaintiffAnalysisResult.csv')

merged_df = pd.merge(average_df, smallest_df, on='PlaintiffName', suffixes=('_average', '_smallest'))

merged_df.sort_values(by='AverageTimeInterval', ascending=False, inplace=True)

top_20_plaintiffs = merged_df.head(20)

plt.figure(figsize=(12, 6))

plt.plot(top_20_plaintiffs['PlaintiffName'], top_20_plaintiffs['AverageTimeInterval'], marker='o', color='skyblue', linestyle="--", label='Average Time Interval')
plt.plot(top_20_plaintiffs['PlaintiffName'], top_20_plaintiffs['TimeInterval'], marker='o', color='lightgreen', label='Smallest Time Interval')

for i, txt in enumerate(top_20_plaintiffs['TotalLawsuits_average']):
    plt.annotate(f'{txt}', (top_20_plaintiffs['PlaintiffName'].iloc[i], top_20_plaintiffs['AverageTimeInterval'].iloc[i]), xytext=(5,5), textcoords='offset points')

plt.text(0.95, 0.1, 'Additional text indicates Total Lawsuits', color='black', fontsize=10, ha='right', transform=plt.gca().transAxes)

plt.xlabel('Plaintiff Name')
plt.ylabel('Time Interval (Days)')
plt.title('Comparison of Average and Smallest Time Intervals for Top 20 Plaintiffs with Smallest Averages')
plt.xticks(rotation=45)
plt.legend()
plt.grid(axis='y')

plt.tight_layout()
plt.show()

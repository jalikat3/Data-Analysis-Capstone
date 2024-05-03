import pandas as pd
import matplotlib.pyplot as plt

data = pd.read_csv('../CSVs/Defendants.csv')

data['Defendant'] = data['Defendant'].apply(lambda x: x.title())

data['Total'] = pd.to_numeric(data['Total'], errors='coerce')
data = data.sort_values(by='Total', ascending=False)

top_data = data.head(10)

fig, ax = plt.subplots(figsize=(10, 6))

ax.axis('off')

table = ax.table(cellText=top_data[['Defendant', 'Total', 'Industry']].values,
                 colLabels=['Defendant', 'Total', 'Industry'],
                 loc='center',
                 cellLoc='center')

table.auto_set_font_size(False)
table.set_fontsize(10)
table.scale(1.2, 1.2)

# Set header row color
for (i, j), cell in table._cells.items():
    if i == 0:
        cell.set_facecolor('#CCE5FF')  # Light blue background for header column

# Save the figure as a PNG
plt.savefig('defendants_table.png', bbox_inches='tight', pad_inches=0.2)

# Show the table
plt.show()

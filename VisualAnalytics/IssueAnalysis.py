import pandas as pd
import matplotlib.pyplot as plt
import matplotlib.colors as mcolors
import numpy as np

# Read the CSV file
data = pd.read_csv('./Results_CSV/issue_top_twenty.csv')

# Sort the data by 'Total' column in descending order
data = data.sort_values(by='Total', ascending=False)

# Reset index
data.reset_index(drop=True, inplace=True)

# Create a colormap based on 'Total' with pastel colors
cmap = plt.cm.get_cmap('Spectral_r')
norm = mcolors.Normalize(vmin=data['Total'].min(), vmax=data['Total'].max())
colors = cmap(norm(data['Total']))

# Reshape colors array to match the shape of the table
num_rows, num_cols = data.shape
colors = np.repeat(colors[:, np.newaxis], num_cols, axis=1)

# Display the data in a table with colored cells
fig, ax = plt.subplots(figsize=(8, 6))
ax.axis('tight')
ax.axis('off')
white_font_colors = np.full_like(colors, 'white', dtype=object)

table = ax.table(cellText=data.values, colLabels=data.columns, cellColours=colors, loc='center')
for (i, j), cell in table.get_celld().items():
    if (i > 0) and (j > -1):
        cell.set_text_props(fontsize=12, color='white', weight='bold')

table.auto_set_font_size(False)
table.set_fontsize(12)
cbar = plt.colorbar(plt.cm.ScalarMappable(norm=norm, cmap=cmap), ax=ax)
cbar.set_label('Total', rotation=270, labelpad=15)

plt.show()

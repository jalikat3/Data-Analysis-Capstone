import pandas as pd
import matplotlib.pyplot as plt
import matplotlib.colors as mcolors
import numpy as np

data = pd.read_csv('../CSVs/TopAllegedIssues.csv')

data = data.sort_values(by='Total', ascending=False)

top_20 = data.head(20)

top_20.reset_index(drop=True, inplace=True)

cmap = plt.cm.get_cmap('Spectral_r')
norm = mcolors.Normalize(vmin=top_20['Total'].min(), vmax=top_20['Total'].max())
colors = cmap(norm(top_20['Total']))

num_rows, num_cols = top_20.shape
colors = np.repeat(colors[:, np.newaxis], num_cols, axis=1)

fig, ax = plt.subplots(figsize=(8, 6))
ax.axis('tight')
ax.axis('off')
white_font_colors = np.full_like(colors, 'white', dtype=object)

table = ax.table(cellText=top_20.values, colLabels=top_20.columns, cellColours=colors, loc='center')
for (i, j), cell in table.get_celld().items():
    if (i > 0) and (j > -1):
        cell.set_text_props(fontsize=12, color='white', weight='bold')

table.auto_set_font_size(False)
table.set_fontsize(12)
cbar = plt.colorbar(plt.cm.ScalarMappable(norm=norm, cmap=cmap), ax=ax)
cbar.set_label('Total', rotation=270, labelpad=15)

plt.show()

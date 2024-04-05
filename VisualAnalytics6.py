import pandas as pd
import matplotlib.pyplot as plt
import textwrap

data = pd.read_csv('./Results_CSV/POUR_Results.csv')
data = data.sort_values(by='Total', ascending=False)

principal = data['POUR_Principal']
total = data['Total']

plt.figure(figsize=(10, 6))

plt.grid(True, linestyle='--', alpha=0.5, zorder=0)
plt.bar(principal, total, color='lightblue', width=0.5, zorder=3)


plt.xlabel('Principal', fontsize=12)
plt.ylabel('Total', fontsize=12)
plt.title('POUR Principals in Alleged Issues', fontsize=14)
plt.legend(fontsize=10)

#plt.xticks(range(len(industries)), industries, fontsize=8, wrap=True, ha='right', rotation=90)
wrapped_labels = [textwrap.fill(label, 17) for label in principal]
plt.xticks(range(len(principal)), wrapped_labels, fontsize=10, ha='right', rotation=10)

plt.yticks(fontsize=10)
for i, value in enumerate(total):
    plt.text(i, value, str(value), ha='center', va='bottom', fontsize=10)

plt.tight_layout()
plt.show()

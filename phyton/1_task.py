import pandas as pd

# Membaca file CSV untuk setiap cabang
branch_a = pd.read_csv('branch_a.csv')
branch_b = pd.read_csv('branch_b.csv')
branch_c = pd.read_csv('branch_c.csv')

# Menggabungkan semua DataFrame menjadi satu
all_branches = pd.concat([branch_a, branch_b, branch_c])

# Membersihkan data: menghapus baris dengan NaN pada kolom transaction_id, date, dan customer_id
all_branches_cleaned = all_branches.dropna(subset=['transaction_id', 'date', 'customer_id'])

# Mengubah kolom 'date' menjadi tipe datetime
all_branches_cleaned['date'] = pd.to_datetime(all_branches_cleaned['date'])

# Menghilangkan duplikat berdasarkan transaction_id dan memilih data berdasarkan date terbaru
all_branches_cleaned = all_branches_cleaned.sort_values('date', ascending=False).drop_duplicates('transaction_id')

# Menghitung total penjualan per cabang
all_branches_cleaned['total_sales'] = all_branches_cleaned['quantity'] * all_branches_cleaned['price']
total_sales_per_branch = all_branches_cleaned.groupby('branch')['total_sales'].sum().reset_index()

# Menyimpan hasil ke file CSV baru
total_sales_per_branch.to_csv('total_sales_per_branch.csv', index=False)

print("Data total penjualan per cabang telah disimpan dalam 'total_sales_per_branch.csv'")

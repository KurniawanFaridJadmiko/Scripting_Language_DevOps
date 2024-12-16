import requests
import pandas as pd

# Fungsi untuk mengambil data dari API berdasarkan parameter 'country'
def get_universities_data(country):
    url = f'http://universities.hipolabs.com/search?country={country}'
    response = requests.get(url)
    data = response.json()
    return data

# Fungsi untuk memfilter dan mengonversi data ke dalam DataFrame pandas
def process_universities_data(data):
    # Membuat DataFrame dari data yang diterima
    df = pd.DataFrame(data)

    # Memilih kolom yang diperlukan
    df_filtered = df[['name', 'web_pages', 'country', 'domains', 'state-province']]

    # Menghapus baris yang tidak memiliki data pada kolom 'state-province'
    df_filtered = df_filtered[df_filtered['state-province'].notna()]

    # Mengubah kolom menjadi format yang lebih rapi
    df_filtered.columns = ['Name', 'Web pages', 'Country', 'Domains', 'State Province']

    return df_filtered

# Parameter pencarian dengan negara
country = "Japan" # "United States"

# Mengambil data universitas berdasarkan negara yang diberikan
universities_data = get_universities_data(country)

# Memproses dan menampilkan data dalam bentuk tabel
df_universities = process_universities_data(universities_data)
print(df_universities)

# Arac-Kiralama-Veritabani-SQL-ProjeOdevi
SQL Server ile hazırlanmış Veritabanı dersi proje ödevi için Araç Kiralama Sistemi ilişkisel veritabanı ve filitreleme analiz sorgulama işlemleri.

# Araç Kiralama Sistemi İlişkisel Veritabanı Tasarımı

##  Proje Amacı
Bu proje, ulusal çapta hizmet veren bir araç kiralama şirketinin günlük işlemlerini dijitalleştirmek ve veri bütünlüğünü sağlamak amacıyla SQL Server üzerinde sıfırdan tasarlanmış ilişkisel bir veritabanı projesidir. Sistem; müşteri kayıtları, araç filosu kategorizasyonu, şube yönetimi ve finansal kiralama işlemlerini güvenli bir şekilde takip etmek üzere kurgulanmıştır.

##  Kullanılan Teknolojiler
* **Veritabanı Yönetim Sistemi:** MS SQL Server
* **Kavramlar:** Veritabanı Tasarımı, ER Diyagramı, Normalizasyon (1NF, 2NF, 3NF), Veri Bütünlüğü Kısıtlamaları (PK, FK, UNIQUE, CHECK).

##  Veritabanı Mimarisi ve Normalizasyon
Tasarlanan sistem, ileride yapılabilecek büyük veri analizleri ve raporlamaları için temiz, tutarlı ve aykırı değerlerden arındırılmış bir altyapı sunmaktadır. 
* **1NF & 2NF:** Tekrarlayan veri grupları engellenmiş, bileşik anahtar yerine her tablonun kendi tekil birincil anahtarı (Primary Key) oluşturulmuştur.
* **3NF:** Geçişli bağımlılıkları engellemek adına, müşteri bilgileri kiralama tablosuna tekrar yazılmamış; araç kategori isimleri özel bir tabloya taşınarak veri tekrarı önlenmiştir.

**Tablolar:**
1. `Kategoriler`: Filodaki araç sınıfları.
2. `Subeler`: Hizmet verilen ofis konumları.
3. `Musteriler`: Müşteri kimlik ve ehliyet bilgileri.
4. `Araclar`: Araç özellikleri ve günlük kiralama bedelleri.
5. `Kiralamalar`: Müşteri, araç, şube ve finansal verilerin birleştiği ana hareket tablosu.

##  Öne Çıkan SQL Sorguları
Proje kapsamında veri tanımlama (DDL) ve veri işleme (DML) dillerinin yanı sıra kompleks analizler için SQL sorguları yazılmıştır:
* Kategori ve şube bazlı filo analizleri (`JOIN`, `GROUP BY`, `HAVING`).
* Kiralama süreleri ve finansal getiri hesaplamaları (`DATEDIFF`, `SUM`, `AVG`, `MAX`, `MIN`).
* İade şubesi ile alış şubesi farklı olan araçların tespiti.

>  **Detaylı Rapor ve ER Diyagramı:** Tablolar arası ilişkileri gösteren ER diyagramı ve sorgu sonuçlarının ekran görüntüleri için Proje_Raporu_ve_ER_Diyagrami.pdf dosyasını inceleyebilirsiniz.
>  **SQL Kodları:** Tablo oluşturma, kısıtlamalar ve sorguların tamamı veritabanı_oluşturma_ve_sorgulama.sql dosyasında bulunmaktadır.

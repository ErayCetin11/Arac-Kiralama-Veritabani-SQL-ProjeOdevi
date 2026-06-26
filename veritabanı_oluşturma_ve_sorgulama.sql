CREATE TABLE Kategoriler (
	KategoriID INT IDENTITY,
	KategoriAdi VARCHAR(50),
	Aciklama NVARCHAR(200)
);
CREATE TABLE Subeler (
    SubeID INT IDENTITY(1,1),
	SubeAdi VARCHAR(100)NOT NULL,
	Sehir VARCHAR(50)NOT NULL,
	Telefon VARCHAR(15) 
)
CREATE TABLE Musteriler (
	MusteriID INT IDENTITY(1,1),
	TCNo CHAR(11)NOT NULL,
	Ad VARCHAR(50) NOT NULL,
	Soyad VARCHAR(50) NOT NULL,
	Telefon VARCHAR(15) NOT NULL,
	Eposta VARCHAR(100),
	EhliyetYasi INT NOT NULL 
);
	CREATE TABLE Araclar (
    AracID INT IDENTITY(1,1),
	Plaka VARCHAR(15) NOT NULL,
	Marka VARCHAR(50) NOT NULL,
	Model VARCHAR(50) NOT NULL,
	Yil INT,
	GunlukUcret DECIMAL(10,2) NOT NULL,
	KategoriID INT NOT NULL,
    MevcutSubeID INT NOT NULL
);
	CREATE TABLE Kiralamalar (
	KiralamaID INT IDENTITY(1,1),
	MusteriID INT NOT NULL,
    AracID INT NOT NULL,
    AlisSubeID INT NOT NULL,
    IadeSubeID INT NOT NULL,
    AlisTarihi DATE NOT NULL,
    IadeTarihi DATE NOT NULL,
    ToplamTutar DECIMAL(10,2) NOT NULL,
);
ALTER TABLE Kategoriler ADD CONSTRAINT PK_Kategoriler PRIMARY KEY (KategoriID);
ALTER TABLE Kategoriler ALTER COLUMN KategoriAdi VARCHAR(50) NOT NULL;
ALTER TABLE Kategoriler ADD CONSTRAINT UQ_Kategori_Adi UNIQUE (KategoriAdi);
ALTER TABLE Kategoriler ADD CONSTRAINT DF_Kategori_Aciklama DEFAULT 'Bilgi Belirtilmemiş' FOR Aciklama;

ALTER TABLE Subeler ADD CONSTRAINT PK_Subeler PRIMARY KEY (SubeID);
ALTER TABLE Subeler ALTER COLUMN Telefon VARCHAR(11) NOT NULL;
ALTER TABLE Subeler ADD CONSTRAINT UQ_Subeler_Telefon UNIQUE (Telefon);
ALTER TABLE Subeler ADD CONSTRAINT CK_Subeler_Telefon CHECK (Telefon LIKE '05%');

ALTER TABLE Musteriler ADD CONSTRAINT PK_Musteriler PRIMARY KEY (MusteriID);
ALTER TABLE Musteriler ADD CONSTRAINT UQ_MusteriTC UNIQUE (TCNo);
ALTER TABLE Musteriler ADD CONSTRAINT UQ_Musteriler_Eposta UNIQUE (Eposta);
ALTER TABLE Musteriler ADD CONSTRAINT CK_Ehliyet_Yas CHECK (EhliyetYasi > 2);

ALTER TABLE Araclar ADD CONSTRAINT PK_Araclar PRIMARY KEY (AracID);
ALTER TABLE Araclar ADD CONSTRAINT UQ_Araclar_Plaka UNIQUE (Plaka);
ALTER TABLE Araclar ALTER COLUMN Yil INT NOT NULL;
ALTER TABLE Araclar ADD CONSTRAINT CHK_Araclar_Yil CHECK (Yil >= 2015);
ALTER TABLE Araclar ADD CONSTRAINT FK_Araclar_Kategoriler FOREIGN KEY (KategoriID) REFERENCES Kategoriler(KategoriID);
ALTER TABLE Araclar ADD CONSTRAINT FK_Araclar_Sube FOREIGN KEY (MevcutSubeId) REFERENCES Subeler(SubeID);

ALTER TABLE Kiralamalar ADD CONSTRAINT PK_Kiralamalar PRIMARY KEY (KiralamaID);
ALTER TABLE Kiralamalar ADD CONSTRAINT CK_Kiralamalar_ToplamTutar CHECK (ToplamTutar >= 0);
ALTER TABLE Kiralamalar ADD CONSTRAINT CK_Kiralamalar_TarihKontrol CHECK (IadeTarihi >= AlisTarihi);
ALTER TABLE Kiralamalar ADD CONSTRAINT FK_Kiralamalar_Musteriler FOREIGN KEY (MusteriID) REFERENCES Musteriler(MusteriID);
ALTER TABLE Kiralamalar ADD CONSTRAINT FK_Kiralamalar_Araclar FOREIGN KEY (AracID) REFERENCES Araclar(AracID);
ALTER TABLE Kiralamalar ADD CONSTRAINT FK_Kiralamalar_AlisSube FOREIGN KEY (AlisSubeID) REFERENCES Subeler(SubeID);
ALTER TABLE Kiralamalar ADD CONSTRAINT FK_Kiralamalar_IadeSube FOREIGN KEY (IadeSubeID) REFERENCES Subeler(SubeID);


INSERT INTO Kategoriler (KategoriAdi, Aciklama) VALUES
('Ekonomik', 'Düşük yakıt tüketimi, şehir içi kullanım için ideal'),
('Sedan', 'Geniş bagaj hacmi ve konforlu aile kullanımı'),
('SUV', 'Yüksek sürüş pozisyonu ve her araziye uygun yapı'),
('Lüks', 'Üst düzey konfor, donanım ve prestij araçları'),
('Hatchback', DEFAULT),
('Ticari', 'Yük taşıma amaçlı, geniş hacimli iş araçları'),
('Elektrikli', 'Sıfır emisyonlu, çevre dostu ve sessiz sürüş');

INSERT INTO Subeler (SubeAdi, Sehir, Telefon) VALUES
('Kadıköy Merkez Şubesi', 'İstanbul', '05321112233'),
('Kızılay Ofis Şubesi', 'Ankara', '05422223344'),
('Karşıyaka Şubesi', 'İzmir', '05553334455'),
('Muratpaşa Şubesi', 'Antalya', '05334445566'),
('Serdivan Şubesi', 'Sakarya', '05355556677'),
('Nilüfer Şubesi', 'Bursa', '05446667788'),
('İzmit Merkez Şubesi', 'Kocaeli', '05527778899');

INSERT INTO Musteriler (TCNo, Ad, Soyad, Telefon, Eposta, EhliyetYasi) VALUES
('11111111111', 'Ahmet', 'Yılmaz', '05329998877', 'ahmet.yilmaz@mail.com', 5),
('22222222222', 'Ayşe', 'Demir', '05428887766', 'ayse.demir@mail.com', 4),
('33333333333', 'Mehmet', 'Kaya', '05557776655', 'mehmet.kaya@mail.com', 10),
('44444444444', 'Fatma', 'Çelik', '05336665544', 'fatma.celik@mail.com', 3),
('55555555555', 'Mustafa', 'Yıldız', '05355554433', 'mustafa.yildiz@mail.com', 8),
('66666666666', 'Zeynep', 'Aydın', '05444443322', 'zeynep.aydin@mail.com', 6),
('77777777777', 'Ali', 'Öztürk', '05523332211', 'ali.ozturk@mail.com', 15),
('88888888888', 'Elif', 'Şahin', '05322221100', 'elif.sahin@mail.com', 7);

INSERT INTO Araclar (Plaka, Marka, Model, Yil, GunlukUcret, KategoriID, MevcutSubeId) VALUES
('34ABC123', 'Renault', 'Clio', 2022, 1200.00, 5, 1), 
('06XYZ456', 'Toyota', 'Corolla', 2021, 1500.00, 2, 2), 
('35DEF789', 'Dacia', 'Duster', 2023, 1800.00, 3, 3), 
('07ANT007', 'Mercedes', 'C200', 2023, 3500.00, 4, 4), 
('54SAK054', 'Fiat', 'Egea', 2022, 1100.00, 1, 5), 
('16BUR116', 'Ford', 'Transit', 2020, 2200.00, 6, 6), 
('41KOC041', 'Tesla', 'Model Y', 2024, 4500.00, 7, 7), 
('34IST034', 'Volkswagen', 'Passat', 2021, 2500.00, 2, 1); 

INSERT INTO Kiralamalar (MusteriID, AracID, AlisSubeID, IadeSubeID, AlisTarihi, IadeTarihi, ToplamTutar) VALUES
(1, 1, 1, 1, '2026-06-01', '2026-06-05', 4800.00), 
(2, 2, 2, 2, '2026-06-02', '2026-06-04', 3000.00), 
(3, 3, 3, 3, '2026-06-10', '2026-06-15', 9000.00), 
(4, 4, 4, 4, '2026-06-12', '2026-06-14', 7000.00), 
(5, 5, 5, 5, '2026-06-15', '2026-06-20', 5500.00), 
(6, 6, 6, 6, '2026-06-18', '2026-06-21', 6600.00), 
(7, 7, 7, 7, '2026-06-20', '2026-06-22', 9000.00), 
(8, 8, 1, 2, '2026-06-22', '2026-06-25', 7500.00), 
(1, 5, 5, 1, '2026-06-26', '2026-06-28', 2200.00), 
(2, 3, 3, 3, '2026-06-05', '2026-06-08', 5400.00);

SELECT Ad, Soyad, EhliyetYasi
FROM Musteriler
WHERE EhliyetYasi >= 5

SELECT Marka, Model,Plaka
FROM Araclar
WHERE Plaka LIKE '%ABC%' OR Marka = 'Ford' 

SELECT * 
FROM Araclar 
WHERE GunlukUcret BETWEEN 1500 AND 3000

SELECT AlisSubeID ,SUM(ToplamTutar) as Toplam_Kazanç
FROM Kiralamalar
GROUP BY AlisSubeID

SELECT a.AracID,s_alis.SubeAdi AS AlisSubesi,s_iade.SubeAdi AS IadeSubesi,
		Marka, Model, Yil, GunlukUcret
FROM Araclar A
JOIN Kiralamalar k ON A.AracID = K.AracID
JOIN Subeler s_alis ON k.AlisSubeID = s_alis.SubeID
JOIN Subeler s_iade ON k.IadeSubeID = s_iade.SubeID
WHERE k.AlisSubeID != k.IadeSubeID

SELECT s.SubeAdi,s.Telefon,k.KategoriID,count(a.AracID) AS Toplam_Adet
FROM Araclar a
JOIN Subeler s ON s.SubeID = a.MevcutSubeID
JOIN Kategoriler k ON a.KategoriID = k.KategoriID
GROUP BY s.SubeAdi,
		 s.Telefon,
		 k.KategoriID
HAVING count(a.AracID) >= 2

SELECT m.Ad,m.Soyad, m.EhliyetYasi,COUNT(k.KiralamaID) AS Toplam_Kiralama_Sayisi
FROM Musteriler m
LEFT JOIN Kiralamalar k ON m.MusteriID = k.MusteriID
WHERE EhliyetYasi >= 5
GROUP BY m.Ad,
		 m.Soyad, 
		 m.EhliyetYasi
HAVING COUNT(k.KiralamaID) < 2

SELECT k.KategoriAdi,COUNT(ki.kiralamaID) as ToplamKiralanmaSayisi,SUM(ki.ToplamTutar) AS ToplamKategoriGeliri,
	   AVG(DATEDIFF(DAY, ki.AlisTarihi, ki.IadeTarihi)) AS OrtalamaKiralamaGunu
FROM Kiralamalar ki
JOIN Araclar a ON a.AracID = ki.AracID
JOIN Kategoriler k ON k.KategoriID = a.KategoriID
GROUP BY k.KategoriAdi
ORDER BY ToplamKategoriGeliri DESC

SELECT 
    SUM(ToplamTutar) AS Toplam_Kazanc,
    AVG(ToplamTutar) AS Ortalama_Kiralama_Bedeli,
    MAX(ToplamTutar) AS En_Yuksek_Kiralama,
    MIN(ToplamTutar) AS En_Dusuk_Kiralama
FROM Kiralamalar;
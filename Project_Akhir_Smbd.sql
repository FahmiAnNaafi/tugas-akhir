create database rumahsakit
use rumahsakit

create table dokter
(
kd_dokter int not null primary key,
nama_dokter varchar (20) not null,
alamat_dokter varchar (30) not null,
spesialisasi varchar (30) not null,
kd_pasien int default null
)

insert into dokter values
(310,'Dr.Fikri','Sokaraja','Dokter anak',111),
(311,'Dr.Fadhila','Baturraden','Dokter kandungan',112),
(312,'Dr.Fahmi','Purbalingga','Dokter mata',113),
(313,'Dr.Dika','Sumbang','Dokter tht',114),
(314,'Dr.Aditya','Solo','Dokter gigi',115),
(315,'Dr.Intan','Jogja','Dokter syaraf',116),
(316,'Dr.Nafi','Wonosobo','Dokter Paru paru',117),
(317,'Dr.Priyanti','Kembaran','Dokter bedah',118),
(318,'Dr.Pratama','Banyumas','Dokter umum',119),
(319,'Dr.Ningrum','Purwokerto','Dokter kulit',120)
select*from dokter

create table pasien
(
kd_pasien int not null primary key,
nama_pasien varchar (30)not null,
alamat_pasien varchar (30)not null,
tgl_datang date not null,
keluhan varchar (30) not null,
kd_dokter int default null
CONSTRAINT FK_pasien_dokter FOREIGN KEY (kd_dokter) REFERENCES dokter (kd_dokter)
)
insert into pasien values
(111,'Jono','Solo','2022-01-01','kulit gatal',319),
(112,'Joni','Jogja','2022-01-01','katarak',312),
(113,'Sinta','Purbalingga','2022-01-01','demam',318),
(114,'Siti','Purwokerto','2022-01-01','hernia',317),
(115,'Jane','Cilacap','2022-01-01','telinga berdenging',313),
(116,'Lingga','Purbalingga','2022-01-01','muntaber',310),
(117,'Zeze','Tegal','2022-01-01','syaraf kejepit',315),
(118,'Rizki','Jakarta','2022-01-01','sakit gigi',314),
(119,'Dini','Purwakarta','2022-01-01','Melahirkan',311),
(120,'Aris','Solo','2022-01-01','Asma',316)
select*from pasien

create table administrasi
(
kd_pembayaran int not null primary key,
Jumlah_pembayaran varchar (30) not null,
tanggal_bayar date not null,
kd_pasien int default null
CONSTRAINT FK_administrasi_pasien FOREIGN KEY (kd_pasien) REFERENCES pasien (kd_pasien)
)

insert into administrasi values
(301,'Rp. 125.000','2022-01-02',111),
(302,'Rp. 12.000.000','2022-01-02',112),
(303,'Rp. 50.000','2022-01-04',113),
(304,'Rp. 8.000.000','2022-01-02',114),
(305,'Rp. 200.000','2022-01-04',115),
(306,'Rp. 300.000','2022-01-02',116),
(307,'Rp. 500.000','2022-01-05',117),
(308,'Rp. 150.000','2022-01-01',118),
(309,'Rp. 4.000.000','2022-01-04',119),
(310,'Rp. 350.000','2022-01-03',120)
select*from administrasi

create table Ruangan
(
no_ruang int not null primary key,
nama_ruangan varchar (30) not null,
kd_pasien int default null
CONSTRAINT FK_Ruangan_pasien FOREIGN KEY (kd_pasien) REFERENCES pasien (kd_pasien)
)

insert into Ruangan values 
(01,'Ruang Anggrek',111),
(02,'Ruang Melati',112), 
(03,'Ruang Mawar',113), 
(04,'Ruang Bougenville',114), 
(05,'Ruang Cempaka',115), 
(06,'Ruang Dahlia',116), 
(07,'Ruang Edelwis',117), 
(08,'Ruang Flamboyan',118), 
(09,'Ruang Sadewa',119), 
(10,'Ruang Nakula',120) 
select*from Ruangan

create table RawatInap
(
kd_rawatinap varchar (30) not null primary key,
kd_pasien int default null,
kd_dokter int default null,
tgl_keluar date,
status_rawat varchar (30) ,
no_ruang int default null,
CONSTRAINT FK_RawatInap_pasien FOREIGN KEY (kd_pasien) REFERENCES pasien (kd_pasien),
CONSTRAINT FK_RawatInap_dokter FOREIGN KEY (kd_dokter) REFERENCES dokter (kd_dokter),
CONSTRAINT FK_RawatInap_Ruangan FOREIGN KEY (no_ruang) REFERENCES Ruangan (no_ruang)
)

insert into RawatInap values
('A10',111,310,'2022-01-7','Masih di Rawat',01),
('B11',112,311,Null,'Sudah Pulang',02),
('C12',113,312,'2022-01-7','Masih di Rawat',03),
('D13',114,313,Null,'Sudah Pulang',04),
('E14',115,314,'2022-01-7','Masih di Rawat',05),
('F15',116,315,'2022-01-7','Masih di Rawat',06),
('G16',117,316,Null,'Sudah Pulang',07),
('H17',118,317,'2022-01-7','Masih di Rawat',08),
('I18',119,318,'2022-01-8','Masih di Rawat',09),
('J19',120,319,'2022-01-14','Masih di Rawat',10)
select*from RawatInap


--JOIN TABLE
select ps.kd_pasien, nama_pasien, keluhan, tgl_keluar, status_rawat
from pasien ps
join RawatInap ri on ps.kd_pasien = ri.kd_pasien

--LEFT JOIN
select ps.kd_pasien, nama_pasien, keluhan, tgl_keluar, status_rawat
from pasien ps
left join RawatInap ri on ps.kd_pasien = ri.kd_pasien

--RIGHT JOIN
select ps.kd_pasien, nama_pasien, keluhan, tgl_keluar, status_rawat
from pasien ps
right join RawatInap ri on ps.kd_pasien = ri.kd_pasien

-- INTERSECTION
select kd_dokter from dokter
intersect 
select kd_dokter from pasien

-- CARTESIAN PRODUCT
select pasien.kd_pasien, pasien.nama_pasien, pasien.keluhan, Ruangan.no_ruang, Ruangan.nama_ruangan
from pasien cross join Ruangan

-- UNION
select kd_dokter from dokter
union
select kd_pasien from pasien order by kd_dokter

--SET DEFFERENCE
select kd_dokter, nama_dokter from dokter 
except 
select kd_pasien, nama_pasien  from pasien

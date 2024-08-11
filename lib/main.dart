import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'hospital_map_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daftar Rumah Sakit Rujukan Covid-19',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HospitalListPage extends StatefulWidget {
  @override
  _HospitalListPageState createState() => _HospitalListPageState();
}

class _HospitalListPageState extends State<HospitalListPage> {
  List hospitals = [];

  @override
  void initState() {
    super.initState();
    fetchHospitals();
  }

  fetchHospitals() async {
    final response = await http.get(Uri.parse('https://dekontaminasi.com/api/id/covid19/hospitals'));
    if (response.statusCode == 200) {
      setState(() {
        hospitals = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load hospitals');
    }
  }

  // Map yang berisi URL gambar untuk setiap rumah sakit
  Map<String, String> hospitalImages = {
    "RS UMUM DAERAH  DR. ZAINOEL ABIDIN": "https://rsudza.acehprov.go.id/assets/uploads/cover_photos/a47dd-863d525b-3dde-47b2-9be1-3d7532c98c5c.jpg",
    "RS UMUM DAERAH CUT MEUTIA KAB. ACEH UTARA": "https://rscutmeutia.acehutara.go.id/media/2023.08/rsu_cm1.jpg",
    "RSUP SANGLAH": "https://static.promediateknologi.id/crop/0x0:0x0/0x0/webp/photo/radarbali/2022/07/ruang-flamboyan-rs-sanglah-tak-dilockdown-pasien-pindah-ke-ruang-lain_m_1591957640_198809.jpg",
    "RS UMUM DAERAH KAB. BULELENG": "https://d1ojs48v3n42tp.cloudfront.net/provider_location_banner/393800_3-3-2020_10-21-23.jpg",
    "RS UMUM DAERAH SANJIWANI GIANYAR": "https://d1ojs48v3n42tp.cloudfront.net/provider_location_banner/822517_3-3-2020_2-57-59.jpg",
    "RS UMUM DAERAH TABANAN": "https://d1ojs48v3n42tp.cloudfront.net/provider_location_banner/225855_3-3-2020_1-51-8.jpg",
    "RS UMUM DAERAH KABUPATEN TANGERANG": "https://rsud-tangerangkab.id/wp-content/uploads/2020/07/DP-RS-1000x650.jpg",
    "RS UMUM DAERAH DR. DRAJAT PRAWIRANEGARA": "https://d1ojs48v3n42tp.cloudfront.net/provider_location_banner/9f77218b-2580-4b72-9206-d5f64f185ed0_provider_location_image_url.webp",
    "RS UMUM DAERAH DR. M. YUNUS BENGKULU": "https://www.bengkuluinteraktif.com/sites/default/files/articles/RSUD%20M%20Yunus%20Bengkulu%20foto%202.jpg",
    "RS UMUM DAERAH ARGA MAKMUR": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHYhj6YsG103emn26UzrZimA1OEnXFlf8t-g&s",
    "RS UMUM DAERAH HASANUDDIN DAMRAH MANNA": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRD1DT_YRjFsKBSOQDnl8eghjjfWVwSSp2MgQ&s",
    "RS UMUM DAERAH PANEMBAHAN SENOPATI": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR-Uc7xCfuo1Rdc69INi0GPVSIGMXwEoWkqsw&s",
    "RS UMUM DAERAH WATES": "https://asset-2.tstatic.net/jogja/foto/bank/images/rsud-wates-kulonprogo_0707.jpg",    
    "RS UMUM DAERAH KOTA YOGYAKARTA": "https://asset.kompas.com/crops/uF1ohLtiVkbUC-vhwdSSPREPs14=/2x0:721x479/750x500/data/photo/2022/11/30/63869c9c170c8.jpg",
    "RSUP DR. SARDJITO": "https://sardjito.co.id/wp-content/uploads/2015/07/22050127.jpg",
    "RS UMUM AL DR MINTOHARJO": "https://fokussehatnews.com/wp-content/uploads/2021/08/RSAL-MintoharjoRepublika.jpg",
    "RS UMUM PAD GATOT SOEBROTO": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRQRN_SfeKqa3wbGMMId6ftMgw9See7-AT4NQ&s",
    "RS UMUM BHAYANGKARA TK. I R.SAID SUKANTO": "https://lh3.googleusercontent.com/proxy/r53KVQnlDuT0dp3o-aVeuCgZuKLnHDyz30kYZM95SMBZlGmivPpe9MW1sC7XI6za362_MOHVudN7i-1b3rriy0aY5Cl56Fd6csK5ItsdODfxLyn-1FiEIZup27JoBNypP5b_APrssQB6vw",
    "RSUP PERSAHABATAN": "https://cdn.antaranews.com/cache/1200x800/2021/11/24/20211116_101601.jpg",
    "RS PENYAKIT INFEKSI PROF. DR. SULIANTI SAROSO": "https://databank-kpap.jakarta.go.id/uploads/organisasi/rspisulis1.jpg",
    "RSUP FATMAWATI": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8M58EUuU7FzeaZPAsi9shssnxjmiLFs_AOg&s",
    "RS UMUM DAERAH PASAR MINGGU": "https://multimedia.beritajakarta.id/photo/potret_jakarta/49dbf4ede4ab625565e661c78b684f5e.jpg",
    "RS UMUM DAERAH CENGKARENG": "https://akcdn.detik.net.id/visual/2020/09/10/rsud-cengkareng_169.jpeg?w=650",
    "RS UMUM DAERAH PROF DR. H. ALOEI SABOE": "https://kfmap.asia/storage/thumbs/storage/photos/ID.GTO.HOS.RSUP/ID.GTO.HOS.RSUP_1.png",
    "RS UMUM DAERAH RADEN MATTAHER JAMBI": "https://jambiindependent.disway.id/upload/1606889bb0688a53ef949a5a1c603b32.jpg",
    "RS PARU DR. H. A. ROTINSULU": "https://static.guesehat.com/static/directories_thumb/47953_Rumah_Sakit_Paru_Dr._H.A._Rotinsulu.jpg",
    "RS UMUM PUSAT DR. HASAN SADIKIN": "https://static.gatra.com/foldershared/images/2020/uqi/03-Mar/IMG-20200319-WA0023.jpg",
    "RS UMUM DAERAH DR. SLAMET GARUT": "https://sippn.menpan.go.id/images/article/large/dr-slamet-2-20240519094548.jpg",
    "RS UMUM TK II DUSTIRA": "https://goalkes-images.s3.ap-southeast-1.amazonaws.com/media/1368/BNEvPpPIX5IicNLQhgvTeYVVOPA4aFnyrIQ2aGA9.jpg",
    "RS PARU DR. M. GOENAWAN PARTOWIDIGDO": "https://d1ojs48v3n42tp.cloudfront.net/provider_location_banner/713186_4-3-2020_16-28-31.jpg",
    "RS UMUM DAERAH  R SYAMSUDIN SH": "https://d1ojs48v3n42tp.cloudfront.net/provider_location_banner/509369_3-3-2020_14-36-13.jpg",
    "RS UMUM DAERAH GUNUNG JATI": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQaV_NZLbp33kNSpVhCrQA3SxWyXi_H4cy1CA&s",
    "RS UMUM DAERAH KAB. INDRAMAYU": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSgjdcYYdxJyRZNb9-DkKGRLlN6uZrlzdSVDw&s",
    "RS UMUM DAERAH K.R.M.T WONGSONEGORO": "https://asset-2.tstatic.net/tribunjatengwiki/foto/bank/images/rswn.jpg",
    "RS UMUM PUSAT DR. KARIADI": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR6HyRdBASFF0QFbSFz5ldpCNAwJUBhd3vQ3g&s",
    "RS UMUM DAERAH KRATON KAB. PEKALONGAN": "https://d1ojs48v3n42tp.cloudfront.net/provider_location_banner/871646_3-3-2020_17-15-12.jpg",
    "RS UMUM DAERAH KARDINAH": "https://img.posjateng.id/img/content/2019/03/19/4103/rsud-kardinah-kota-tegal-kantongi-akreditasi-paripurna-R81tZ4Jvua.jpg",
    "RS UMUM PUSAT DR. SOERADJI TIRTONEGORO": "https://d1ojs48v3n42tp.cloudfront.net/provider_location_banner/573909_3-3-2020_14-24-34.jpg",
    "RS UMUM DAERAH DR. SOESELO SLAWI KABUPATEN TEGAL": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTBfXLk6sxVjhqYtaqPLPqMDqtVVMHdRjBlgQ&s",
    "RS UMUM DAERAH PROF DR. MARGONO SOEKARJO PURWOKER": "https://goalkes-images.s3.ap-southeast-1.amazonaws.com/media/447/ROp80pMiXWx0wiHAIZXj0Pg8V539oO6aRtWXU3Q2.jpg",
    "RS UMUM DAERAH  DR. H. SOEWONDO KENDAL": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRN0ZXq41gP8LPM5bYSonPTV0drLcAoFNjxfg&s",
    "RS UMUM DAERAH DR. MOEWARDI SURAKARTA": "https://www.saranamedical.com/uploads/posts/client/20191017094508.jpg",
    "RS UMUM DAERAH TIDAR": "https://lh3.googleusercontent.com/proxy/n8M7R84U_vVFLwlTEddxdZObWM7Ws-If4rcGsv1DoL3zoGKDFZR1eutN37LduTzxLRLtZzGUpXMWfsXyRzEpbTu4xOTe1tf7xXrzvao2bZqq8RXFaf01nF0",
    "RSUD BANYUMAS": "https://diklitbangrsbms.banyumaskab.go.id/mendoan_bang_kombas/pluginfile.php/230/course/overviewfiles/IMG20190222123258.jpg",
    "RS PARU DR. ARIO WIRAWAN": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRHqTojP8d2HVRELWdKGKNBT0_LqZJTsJzKw&s",
    "RS UMUM DAERAH DR. LOEKMONO HADI": "https://lh4.googleusercontent.com/proxy/2DmkBqDGZtpKJBwCleMn2KX3wZ2gcqC3OL7PQPCaKblpW5tEPfoP2vvLidHukG5CeI1aG4EOnqKwZI4vI0yMTrfGbxvL7iSuIDTspL5jHMSJZwAtwTOh1AuL-GGMZ4IQzdtxu1JvR1Gn0FlBu3W4Ay0I__6GOQ",
    "RS UNIVERSITAS AIRLANGGA": "https://rumahsakit.unair.ac.id/website/wp-content/uploads/2014/05/Rumah-Sakit-Universitas-Airlangga.png",
    "RS UMUM DAERAH DR. SOETOMO": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRXM17dkkJAdi2MDCQgrLAzbrnfW9YhgIbbRQ&s",
    "RS UMUM DAERAH DR. SOEDONO MADIUN": "https://d1ojs48v3n42tp.cloudfront.net/provider_location_banner/686963_24-1-2020_14-39-10.jpg",
    "RS UMUM DAERAH DR. SAIFUL ANWAR": "https://rsusaifulanwar.jatimprov.go.id/image_header/Header_Mobile_Port.jpg",
    "RS UMUM DAERAH DR. R. KOESMA TUBAN": "https://infopublik.id/assets/upload/headline//WhatsApp_Image_2023-10-13_at_14_58_04.jpeg",
    "RS UMUM DAERAH DR. R. SOSODORO DJATIKOESOEMO": "https://d1ojs48v3n42tp.cloudfront.net/provider_location_banner/270403_4-3-2020_18-18-46.jpg",
    "RS UMUM DAERAH SIDOARJO": "https://simpkl.smksepuluhnopembersda.sch.id/public/assets/industri/images.jpg",
    "RS UMUM DAERAH BLAMBANGAN": "https://awsimages.detik.net.id/community/media/visual/2021/10/03/rsud-blambangan_169.jpeg?w=1200",
    "RS UMUM DAERAH DR. SOEBANDI": "https://assets.promediateknologi.id/crop/0x0:0x0/750x500/webp/photo/p1/741/2023/08/17/WhatsApp-Image-2023-08-17-at-102047-1-2792146160.jpeg",
    "RS UMUM DAERAH KABUPATEN KEDIRI": "https://d1ojs48v3n42tp.cloudfront.net/provider_location_banner/181089_3-3-2020_0-49-32.png",
    "RS UMUM DAERAH DR. ISKAK TULUNGAGUNG": "https://i0.wp.com/rsud.tulungagung.go.id/wp-content/uploads/2020/05/foto-rsud.jpg?fit=826%2C411&ssl=1",
    "RS UMUM DAERAH DR. SOEDARSO PONTIANAK": "https://asset.kompas.com/crops/OCkqHs6IZgnP7gbJSKsViLvfjsU=/24x0:614x393/750x500/data/photo/2022/08/09/62f1fdbe52fc7.jpg",
    "RS UMUM DAERAH ADE MUHAMMAD DJOEN SINTANG": "https://rsudsintang.com/wp-content/uploads/2018/09/RSUD-Ade-tempo-dulu.jpg",
    "RS UMUM DAERAH DR. AGOESDJAM KETAPANG": "https://hariantribuana.co/wp-content/uploads/2023/04/IMG-20230428-WA0021.jpg",
    "RS UMUM DAERAH DR. ABDUL AZIZ SINGKAWANG": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRl71N5QxPMpezHeIKFczQRvbhJvAy8XKCgaQ&s",
    "RS UMUM DAERAH ULIN BANJARMASIN": "https://upload.wikimedia.org/wikipedia/commons/b/bf/Rumah_Sakit_Umum_Daerah_Ulin.jpg",
    "RS UMUM DAERAH H. BOEJASIN PELAIHARI": "https://cdn.antaranews.com/cache/1200x800/2019/09/23/WhatsApp-Image-2019-09-23-at-20.33.08.jpeg",
    "RS UMUM DAERAH DR DORIS SYLVANUS PALANGKA RAYA": "https://www.borneonews.co.id/images/upload/2024/03/20/1710923743-untitled-1.jpg",
    "RS UMUM DAERAH SULTAN IMANUDDIN": "https://rssi.kotawaringinbaratkab.go.id/assets/upload/image/thumbs/img20210416100055-00-1618798242.jpg",
    "RS UMUM DAERAH DR MURJANI SAMPIT": "https://www.persi.or.id/wp-content/uploads/2024/03/RSUD-drMurjani-Sampit.png",
    "RS UMUM DAERAH ABDUL WAHAB SJAHRANIE": "https://diskominfo.kaltimprov.go.id/storage/image/GTXy42wKCyVSSl5Q.JPG",
    "RS UMUM DAERAH TAMAN HUSADA": "https://asset-2.tstatic.net/kaltim/foto/bank/images/coron-senninn.jpg",
    "RS UMUM DAERAH DR. KANUJOSO DJATIWIBOWO": "https://rsudkanujoso.kaltimprov.go.id/storage/slider/slider-1679367568.rskd%20dari%20drone.jpg",
    "RS UMUM DAERAH AJI MUHAMMAD PARIKESIT": "https://rsamp.kukarkab.go.id/storage/photos/shares/articles/hak-jawab-publikasi-warga-pada-media-sosial-facebook-tanggal-3-mei-2024-rsud-aji-muhammad-parikesit-tenggarong-kutai-kartanegara.jpg",
    "RS UMUM DAERAH PANGLIMA SEBAYA": "https://static.guesehat.com/static/directories_thumb/40809_Rumah_Sakit_Umum_Daerah_Panglima_Sebaya.jpg",
    "RS UMUM DAERAH TANJUNG SELOR": "https://d1ojs48v3n42tp.cloudfront.net/provider_location_banner/320124_4-3-2020_16-31-16.jpg",
    "RS UMUM KOTA TARAKAN": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQOehP4F8lNcDjaQqMUzeDFzxp1QDry3-nsSw&s",
    "RS UMUM DAERAH DEPATI HAMZAH": "https://d1ojs48v3n42tp.cloudfront.net/provider_location_banner/467399_13-3-2020_13-55-40.jpg",
    "RS UMUM DAERAH DR. H. MARSIDI JUDONO": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8NybApu_Tnmg4AC1aeFhcfB4mSR0Wc_gVIw&s",
    "RS UMUM DAERAH PROVINSI KEPULAUAN RIAU TANJUNGPINA": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQd-Rq5Qdl2JTyWrfEA0F-HPl6ZS-XNxFJhHQ&s",
    "RS BADAN PENGUSAHAAN BATAM": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR-gJ1O8YzIbdBhZ5MlEGmVZF2Op92jmkDhMA&s",
    "RS UMUM DAERAH EMBUNG FATIMAH KOTA BATAM": "https://d1ojs48v3n42tp.cloudfront.net/provider_location_banner/124289_4-3-2020_14-12-58.jpg",
    "RS UMUM DAERAH MUHAMMAD SANI KABUPATEN KARIMUN": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJXKvvhuB8R-ZMUHhjg1UIGJ_u1ZqWyeMXJA&s",
    "RS UMUM DAERAH DR H ABDUL MOELOEK": "https://rsudam.lampungprov.go.id/berkas/uploads/WNOFNcNdOHfYHefKlI0PT0uYcgNNLRyrrZnhy2D3.jpg",
    "RS UMUM DAERAH AHMAD YANI METRO": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRpjsLKa6fidojy7_a0CQCNT4fByAk5EXXkZA&s",
    "RS UMUM DAERAH MAY JEN HM RYACUDU": "https://static.guesehat.com/static/directories_thumb/9032_Rumah_Sakit_Umum_Mayjend_H_M_Ryacudu.JPG",
    "RS UMUM DAERAH DR. H. BOB BAZAR, SKM": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQ-DqhJZ4XwHspYwtPyMyC4UZnSF3vATqMiQ&s",
    "RS UMUM PUSAT DR. J. LEIMENA": "https://lh6.googleusercontent.com/proxy/giJJ0YnY2v7kCIDe5D-Jfja4fva_R-RTsfF_QVpIuv6QNLrJbcSb2sJpIcfPsIQ8yO3F1EMB8SILfylehCuUGa6meOYwTLUSUCnGprwusOwuTr1J0J1t4As_tnkAACCgwdVW",
    "RS UMUM DR. M. HAULUSSY AMBON": "https://d1ojs48v3n42tp.cloudfront.net/provider_location_banner/76538_13-3-2020_15-29-56.jpg",
    "RS UMUM DAERAH DR. P. P. MAGRETTI SAUMLAKI": "https://goalkes-images.s3.ap-southeast-1.amazonaws.com/media/2557/FYr11Zd9u4CktG4owNzLDYZYuuRBko4QhPDeYCPR.jpg",
    "RS UMUM DAERAH DR. H. CHASAN BOESOIRIE TERNATE": "https://halmaheraraya.id/wp-content/uploads/2022/12/RSUD-Dr.-H.-Chasan-Boesoirie.jpg",
    "RS UMUM DAERAH NTB": "https://awsimages.detik.net.id/community/media/visual/2023/06/06/gedung-rsud-provinsi-ntb_169.jpeg?w=1200",
    "RS UMUM DAERAH DR. R. SOEDJONO SELONG": "https://cdn.rri.co.id/berita/Mataram/o/1714208510228-9/y62wibdfeluk1jo.jpeg",
    "RS UMUM BIMA": "https://d1ojs48v3n42tp.cloudfront.net/provider_location_banner/176319_13-3-2020_15-33-11.jpg",
    "RS H. L. MANAMBAI ABDULKADIR": "https://d1ojs48v3n42tp.cloudfront.net/provider_location_banner/639494_12-3-2020_17-27-6.jpg",
    "RS UMUM PROF DR WZ JOHANES": "https://static.guesehat.com/static/directories_thumb/RS000138_Rumah_Sakit_Umum_Daerah_Prof_Dr_W_Z_Johannes_Kupang.JPG",
    "RS UMUM DAERAH DR TC HILLERS MAUMERE": "https://d1ojs48v3n42tp.cloudfront.net/provider_location_banner/623574_4-3-2020_17-28-23.jpg",
    "RS UMUM DAERAH KOMODO": "https://www.jurnalbali.com/wp-content/uploads/2023/09/RS-UD-Labuan-Bajo.jpg",
    "RS UMUM JAYAPURA": "https://papua.go.id/files/news/1580423816.Gedung%20Instalasi%20Rawat%20Jalan%20RSUD%20Jayapura.jpg",
    "RS UMUM MERAUKE": "https://www.infopublik.id/assets/upload/headline//RSUD_Merauke1.jpg",
    "RS UMUM NABIRE": "https://d1ojs48v3n42tp.cloudfront.net/provider_location_banner/650479_13-3-2020_16-28-23.jpg",
    "RS UMUM DAERAH MANOKWARI": "https://d1ojs48v3n42tp.cloudfront.net/provider_location_banner/730075_13-3-2020_16-29-17.jpg",
    "RS UMUM DAERAH KABUPATEN SORONG": "https://rsud-sorong.s3.ap-southeast-1.amazonaws.com/20231012133814_tentangkamicover.jpeg",
    "RS UMUM DAERAH  ARIFIN ACHMAD": "https://smarttourism.pekanbaru.go.id/storage/destinations/17733-rsud-arifin-achmad.jpg",
    "RS UMUM DAERAH  KOTA DUMAI": "https://d1ojs48v3n42tp.cloudfront.net/provider_location_banner/66613_4-3-2020_18-45-0.jpg",
    "RS UMUM DAERAH  PURI HUSADA TEMBILAHAN": "https://www.indragirione.com/assets/berita/original/34872852591-31281417002-img-20220407-wa0006.jpg",
    "RS UMUM DAERAH PROVINSI SULAWESI BARAT": "https://d1ojs48v3n42tp.cloudfront.net/provider_location_banner/627286_4-3-2020_3-38-1.jpg",
    "RSUP DR. WAHIDIN SUDIROHUSODO": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRluOJkV8uXmbfZzlEa8688clHB7qdoM_VGsA&s",
    "RS DR. TADJUDDIN CHALID, MPH": "https://d1ojs48v3n42tp.cloudfront.net/provider_location_banner/98044_4-3-2020_1-2-26.jpg",
    "RS UMUM DAERAH LABUANG BAJI": "https://d1ojs48v3n42tp.cloudfront.net/provider_location_banner/374730_3-3-2020_11-59-43.jpg",
    "RS TK.II PELAMONIA": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQrCTTLGhlYS6QIE4_HjOD_QTRZhI8OsUSAhQ&s",
    "RS UMUM DAERAH LAKIPADADA": "https://d1ojs48v3n42tp.cloudfront.net/provider_location_banner/3cd1dcb1-94e4-4692-a72d-10e06b971437_provider_location_image_url.webp",
    "RS UMUM DAERAH KABUPATEN SINJAI": "https://asset.kompas.com/crops/_EqTh9451w2wR5Ue3LjXay8StFo=/0x0:0x0/750x500/data/photo/2020/03/05/5e60ebda3fa6a.jpg",
    "RS UMUM DAERAH ANDI MAKKASAU PAREPARE": "https://rakyatsulsel.fajar.co.id/wp-content/uploads/2022/12/RSUD-Andi-Makkasau-2.jpg",
    "RS UMUM DAERAH UNDATA PALU": "https://theopini.id/wp-content/uploads/2023/06/WhatsApp-Image-2023-06-03-at-00.02.11.jpg",
    "RS UMUM ANUTAPURA PALU": "https://d1ojs48v3n42tp.cloudfront.net/provider_location_banner/304154_26-3-2020_21-45-9.jpg",
    "RS UMUM  MOKOPIDO TOLI-TOLI": "https://cdn.rri.co.id/berita/Toli_Toli/o/1713609319365-1l358w5wbarkz05/mhhebp1l3w1c50b.jpeg",
    "RS UMUM DAERAH KOLONEDALE": "https://goalkes-images.s3.ap-southeast-1.amazonaws.com/media/1220/wirfbZ2J3i4GQXRvjV1qbVQazOumseLo9fwDuDP6.jpg",
    "RS UMUM DAERAH KABUPATEN BANGGAI": "https://goalkes-images.s3.ap-southeast-1.amazonaws.com/media/846/foUGWR5KvAVN7k3ra2rI69V2AYqAFHIgxMXopXJx.jpg",
    "RS BAHTERAMAS PROVINSI SULTRA": "https://cdn.rri.co.id/RS%20BAHTERAMAS.jpg/1672907846-RS%20BAHTERAMAS.jpg",
    "RSUP PROF. DR. R. D. KANDOU": "https://media.licdn.com/dms/image/C511BAQFK6hYkvAxwBw/company-background_10000/0/1584485866186/rsupkandou_cover?e=2147483647&v=beta&t=g3avgrb-p-k6LF_QTS1kqh5zU-UYkmobEe6OcKg3gDY",
    "RS UMUM DR.SAM RATULANGI": "https://d1ojs48v3n42tp.cloudfront.net/provider_location_banner/aa52a734-a8a9-41a2-9509-b2832a20be3a_provider_location_image_url.webp",
    "RSU RATATOTOK - BUYAT": "https://d1ojs48v3n42tp.cloudfront.net/provider_location_banner/710868_4-3-2020_17-35-25.jpg",
    "RS UMUM DAERAH KOTA KOTAMOBAGU": "https://d1ojs48v3n42tp.cloudfront.net/provider_location_banner/36717_4-3-2020_14-46-48.jpg",
    "RSUP DR. M. DJAMIL": "https://www.padang.go.id/uploads/images/image_default_621d9c4971a6a.jpg",
    "RS UMUM DAERAH DR. ACHMAD MOCHTAR": "https://d1ojs48v3n42tp.cloudfront.net/provider_location_banner/601313_2-3-2020_23-1-20.jpg",
    "RS UMUM DAERAH SITI FATIMAH PROVINSI SUMATERA SELATAN": "https://lh5.googleusercontent.com/proxy/mNDb05lnU9v9WPYWiCNtCEthOFLD7nEmdveghUHnj580O4IiZZ5nxwZQV_oaoNDDRG0w3IXLLm0j2MX_cRvQzmbTNrclNwxih5P2eZMlla6krPK5BUdFdOEXhS0DrZG-gwDAOW_MgS4B-g",
    "RS UMUM PUSAT DR. MOHAMMAD HOESIN PALEMBANG": "https://d1ojs48v3n42tp.cloudfront.net/provider_location_banner/601639_23-1-2020_15-9-5.jpg",
    "RS UMUM DAERAH LAHAT": "https://goalkes-images.s3.ap-southeast-1.amazonaws.com/media/1202/LLSIHskYXOIeK9FIdnpSXH2VZsatzQJl7meeZYNE.jpg",
    "RS DR. RIVAI ABDULLAH": "https://saranamedical.com/uploads/posts/client/20220121125758.png",
    "RS UMUM DAERAH KAYUAGUNG": "https://d1ojs48v3n42tp.cloudfront.net/provider_location_banner/879398_3-3-2020_0-21-17.jpg",
    "RSUP H. ADAM MALIK": "https://goalkes-images.s3.ap-southeast-1.amazonaws.com/media/388/7qQSH2wlRfM2XZn8cMrF7kjGlI8tP4CSlIAKhuDN.jpg",
    "RS UMUM DAERAH DR. DJASAMEN SARAGIH": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTatZ816MJArQDkqYQJpj7bEiWUdTDOSD6ZwQ&s",
    "RS UMUM DAERAH KABANJAHE": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRGzDMH5CYRBRmN80GSpCbEtYr8zdUHbfjHJQ&s",
    "RS UMUM DAERAH PADANG SIDEMPUAN": "https://d1ojs48v3n42tp.cloudfront.net/provider_location_banner/44214_4-3-2020_18-49-22.jpg",
    "RS UMUM DAERAH TARUTUNG": "https://goalkes-images.s3.ap-southeast-1.amazonaws.com/media/937/WnceF6XbKnOqkbr7dpmkTZvVRDC5X3YS0fPMz87T.jpg",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Rumah Sakit Rujukan'),
      ),
      body: ListView.builder(
        itemCount: hospitals.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Container(
                  width: 80, // Atur lebar gambar
                  height: 80, // Atur tinggi gambar
            child: CachedNetworkImage(
                imageUrl: hospitalImages[hospitals[index]['name']] ??
                'https://via.placeholder.com/100', // Gambar placeholder jika URL tidak tersedia
                fit: BoxFit.cover, // Memastikan gambar memenuhi ukuran container
              ),
            ),
            title: Text(hospitals[index]['name']),
            subtitle: Text(hospitals[index]['address']),
            onTap: () {
              Navigator.push(
              context,
              MaterialPageRoute(
            builder: (context) => HospitalMapPage(province: hospitals[index]['province']),
                        ),
                      );
                    }, 
                  ),
                );
              },
            ),
          );
        }
      }

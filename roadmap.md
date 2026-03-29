# KaloriHesap - Kalori Hesaplama Uygulaması
## App Store için Swift / SwiftUI ile Geliştirme Yol Haritası

---

## Proje Özeti
iOS için kalori takip ve hesaplama uygulaması. Kullanıcılar günlük besin tüketimini takip edebilir, makro besin değerlerini görebilir ve sağlıklı beslenme hedeflerine ulaşabilir.

---

## AŞAMA 1 — Proje Kurulumu ve Temel Yapı
**Hedef:** Xcode projesi, mimari ve veri modeli

- [ ] Xcode projesi oluşturma (SwiftUI, iOS 17+)
- [ ] Klasör yapısı: Models / Views / ViewModels / Services / Helpers
- [ ] SwiftData entegrasyonu (local database)
- [ ] Temel veri modelleri: `Food`, `Meal`, `DailyLog`, `UserProfile`
- [ ] App renk paleti ve tipografi (Design System)

---

## AŞAMA 2 — Kullanıcı Profili & Hedef Belirleme
**Hedef:** Onboarding akışı ve kişisel hedef hesaplama

- [ ] Onboarding ekranları (yaş, cinsiyet, boy, kilo)
- [ ] Aktivite seviyesi seçimi
- [ ] Günlük kalori hedefi otomatik hesaplama (Harris-Benedict formülü)
- [ ] Makro hedefleri: Protein / Karbonhidrat / Yağ
- [ ] UserDefaults / SwiftData ile profil kaydetme

---

## AŞAMA 3 — Yemek Veritabanı & Arama
**Hedef:** Besin arama ve ekleme sistemi

- [ ] Yerleşik Türkçe yemek veritabanı (JSON dosyası, 500+ yemek)
- [ ] Arama ekranı (gerçek zamanlı filtreleme)
- [ ] Barkod tarayıcı (AVFoundation ile kamera entegrasyonu)
- [ ] Manuel besin ekleme formu
- [ ] Son kullanılan ve favori yemekler listesi

---

## AŞAMA 4 — Günlük Takip Ekranı
**Hedef:** Ana ekran — günlük öğün ve kalori takibi

- [ ] Ana Dashboard (günlük özet, kalan kalori halkası)
- [ ] Öğün grupları: Kahvaltı / Öğle / Akşam / Atıştırmalık
- [ ] Yemek ekleme / düzenleme / silme
- [ ] Makro dağılımı grafikleri (Charts framework)
- [ ] Su takibi widget'ı

---

## AŞAMA 5 — İstatistikler & Geçmiş
**Hedef:** Haftalık/aylık raporlar

- [ ] Haftalık kalori grafiği
- [ ] Kilo takibi (girdi + grafik)
- [ ] Makro trendleri (7 gün / 30 gün)
- [ ] Hedef vs gerçekleşen karşılaştırma
- [ ] Streak (ardışık gün) takibi

---

## AŞAMA 6 — Widget & Bildirimler
**Hedef:** Sistem entegrasyonları

- [ ] Home Screen Widget (WidgetKit) — kalan kalori
- [ ] Günlük öğün hatırlatıcı bildirimleri
- [ ] Lock Screen widget
- [ ] Siri Shortcuts entegrasyonu

---

## AŞAMA 7 — UI Cila & Animasyonlar
**Hedef:** App Store kalitesinde görünüm

- [ ] Animasyonlar ve geçişler (matched geometry, spring)
- [ ] Dark Mode desteği
- [ ] Dynamic Type (erişilebilirlik)
- [ ] Haptic feedback
- [ ] App ikonu tasarımı

---

## AŞAMA 8 — App Store Hazırlığı
**Hedef:** Yayın süreci

- [ ] TestFlight ile beta test
- [ ] App Store ekran görüntüleri (6.7", 6.1", iPad)
- [ ] App Store açıklaması (TR + EN)
- [ ] Privacy Policy sayfası
- [ ] App Store Connect yapılandırması
- [ ] Review için gönderim

---

## Teknoloji Yığını
| Katman | Teknoloji |
|--------|-----------|
| UI | SwiftUI |
| Veri | SwiftData |
| Grafikler | Swift Charts |
| Kamera/Barkod | AVFoundation |
| Widget | WidgetKit |
| Min iOS | iOS 17.0 |

---

## Tahmini Süre
| Aşama | Süre |
|-------|------|
| Aşama 1 | 1 gün |
| Aşama 2 | 2 gün |
| Aşama 3 | 3 gün |
| Aşama 4 | 3 gün |
| Aşama 5 | 2 gün |
| Aşama 6 | 2 gün |
| Aşama 7 | 2 gün |
| Aşama 8 | 1 gün |
| **Toplam** | **~16 gün** |

# Quiz Application

Bu loyiha foydalanuvchilarga viktorinalar yaratish, tahrirlash va o'tkazish imkonini beruvchi veb-ilovani o'z ichiga oladi.

## Texnologiyalar

Loyihada quyidagi texnologiyalar va kutubxonalar ishlatilgan:

### Backend

- **Java 17** - Asosiy dasturlash tili
- **Jakarta EE 10** - Enterprise Edition spetsifikatsiyasi
  - Jakarta Servlet 6.1.0
  - Jakarta Persistence API (JPA) 3.1.0
  - Jakarta Server Pages (JSP)
  - JSTL 3.0.0
- **Hibernate 6.6.11** - ORM (Object-Relational Mapping) frameworki
- **PostgreSQL 42.7.4** - Ma'lumotlar bazasi
- **Maven** - Loyiha boshqarish va build qilish vositasi

### Frontend

- **HTML/CSS** - Asosiy frontend texnologiyalari
- **Bootstrap 5.3.2** - Responsive dizayn uchun CSS frameworki
- **JSP (Jakarta Server Pages)** - Dinamik veb-sahifalar yaratish uchun

### Boshqa kutubxonalar

- **Lombok** - Kod hajmini kamaytirish uchun annotatsiyalar
- **Reflections 0.9.12** - Runtime vaqtida klass va metodlarni tekshirish uchun

## Loyiha tuzilishi

Loyiha quyidagi asosiy komponentlardan tashkil topgan:

### Model

- `Quiz` - Viktorina ma'lumotlarini saqlash uchun
- `Question` - Viktorina savollari
- `AnswerOption` - Savollar uchun javob variantlari

### Servlet

- `QuizServlet` - Viktorinalar ro'yxatini ko'rsatish
- `CreateQuiz` - Yangi viktorina yaratish
- `EditQuizServlet` - Mavjud viktorinani tahrirlash
- `DeleteQuizServlet` - Viktorinani o'chirish
- `UserQuizServlet` - Foydalanuvchilar uchun viktorinalar ro'yxati
- `TakeQuizServlet` - Viktorinani o'tkazish
- `SubmitQuizResult` - Viktorina natijalarini saqlash
- `ViewQuizServlet` - Viktorina tafsilotlarini ko'rish

### Konfiguratsiya

- `StartStopListener` - Ilova ishga tushganda EntityManagerFactory yaratish

## Ma'lumotlar bazasi

Loyiha PostgreSQL ma'lumotlar bazasidan foydalanadi. Ma'lumotlar bazasi konfiguratsiyasi `persistence.xml` faylida belgilangan:

- **Database**: PostgreSQL
- **Schema**: lesson9
- **Connection Pool Size**: 10

## O'rnatish va ishga tushirish

1. Loyihani clone qiling
2. PostgreSQL ma'lumotlar bazasini o'rnating va `modul7` nomli baza yarating
3. `lesson9` sxemasini yarating
4. Ma'lumotlar bazasi foydalanuvchi nomi va parolini `persistence.xml` faylida sozlang
5. Loyihani Maven yordamida build qiling: `mvn clean package`
6. WAR faylni Tomcat yoki boshqa servlet konteyneriga deploy qiling
7. Brauzerda `http://localhost:8080/lesson9` manzilini oching

## Asosiy funksionallik

- Viktorinalar yaratish va tahrirlash
- Savol va javob variantlarini qo'shish
- Viktorinalarni o'tkazish
- Natijalarni ko'rish

## Ishlab chiquvchi

Asrorbek tomonidan yaratilgan
# Persian-digits-database-
Persian digits database with different font types (MATLAB script), مجموعه داده ارقام فارسی با فونت های مختلف
مجموعه فوق شامل یک اسکریپت متلب (نسخه 2016) برای ایجاد مجموعه داده ای از تصاویر مربوط به ارقام فارسی است. این ارقام می توانند به صورت تایپ شده یا دست نویس باشند. فقط کافیست به ازای هر کلاس (هر رقم) یک تصویر با پس زمینه سفید که ارقام آن کلاس با فونت ها یا دستخطهای مختلف بر روی آن تایپ یا نوشته شده اند ایجاد کنید و آن فایل را به نام آن کلاس نامگذاری کنید و سپس اسکریپت را اجرا نمایید. اسکریپت تهیه شده به ازای هر فایل که شامل چند نمونه پایه از یک کلاس خاص است فونت ها یا دستخط های مختلف را با استفاده از مفهموم پیوستگی پیکسلها به صورت یک مجموعه پیوسته جدا می کند و سپس تغییراتی از قبیل تغییر اندازه، چرخش، افزودن نویز، کدر کردن و ... را بر روی آن نمونه ایجاد کرده و آن را به اندازه دلخواه (که در این اسکریپت 32*32 می باشد) ذخیره می نماید.
جزییات بیشتر در کد کامنت شده است.
امیدوارم که این اسکریپت مفید باشد.

 
The above collection includes a Matlab script (version 2016) to create an image dataset of digits (English, Arabic, Persian or any other language). These digits can be typed or handwritten. Just create a .png image for each class (each digit, it can be used to create classes other than digits) with a white background and black typed or written digits, and name that file as that class, and then run the script. For each file, which contains several base instances of a particular class, the script separates different connected component and applies some deformation (such as resizing, rotation, adding noise , Blurring and ...) to it. Finally the script saves the sample in m*n .png image  (in this script 32*32).

The details are commented in code.
I hope this script will be useful.

Sample images:
![sampleimages](https://user-images.githubusercontent.com/34601110/34071332-3de48cc8-e28a-11e7-8bf2-8409eed2d986.png)


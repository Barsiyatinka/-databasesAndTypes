# Домашнее задание к занятию   
**"`Базы данных, их типы`"** - `Воскобойников Арсений Петрович`  
   
**Задание 1**  
``` 
Задание 1. СУБД  
Кейс  
Крупная строительная компания, которая также занимается проектированием и девелопментом, решила создать правильную архитектуру для работы с данными. Ниже представлены задачи, которые необходимо решить для каждой предметной области.  

Какие типы СУБД, на ваш взгляд, лучше всего подойдут для решения этих задач и почему?  

1.1. Бюджетирование проектов с дальнейшим формированием финансовых аналитических отчётов и прогнозирования рисков. СУБД должна гарантировать целостность и чёткую структуру данных.  

1.1.* Хеширование стало занимать длительно время, какое API можно использовать для ускорения работы?  

1.2. Под каждый девелоперский проект создаётся отдельный лендинг, и все данные по лидам стекаются в CRM к маркетологам и менеджерам по продажам. Какой тип СУБД лучше использовать для лендингов и для CRM? СУБД должны быть гибкими и быстрыми.  

1.2.* Можно ли эту задачу закрыть одной СУБД? И если да, то какой именно СУБД и какой реализацией?  

1.3. Отдел контроля качества решил создать базу по корпоративным нормам и правилам, обучающему материалу и так далее, сформированную согласно структуре компании. СУБД должна иметь простую и понятную структуру.  

1.3.* Можно ли под эту задачу использовать уже существующую СУБД из задач выше и если да, то как лучше это реализовать?  

1.4. Департамент логистики нуждается в решении задач по быстрому формированию маршрутов доставки материалов по объектам и распределению курьеров по маршрутам с доставкой документов. СУБД должна уметь быстро работать со связями.  

1.4.* Можно ли к этой СУБД подключить отдел закупок или для них лучше сформировать свою СУБД в связке с СУБД логистов?  

1.5.* Можно ли все перечисленные выше задачи решить, используя одну СУБД? Если да, то какую именно?  

Приведите ответ в свободной форме.  
``` 

**Ответ**  
1.1 - PostgreSQL - почему: Это реляционная СУБД, которая обеспечивает строгую целостность данных, поддерживает ACID-транзакции (что критично для финансовых приложений)

1.1* - Redis.

1.2 - MongoDB или Cassandra - Почему: Эти СУБД хорошо справляются с неструктурированными и полуструктурированными данными, которые могут приходить с лендингов  
MongoDB, в частности, удобна для хранения документов и предоставляет гибкую схему данных.  

Cassandra — хороша для высоконагруженных систем, где важна скорость записи и масштабируемость.  

1.2* - Да, можно использовать MongoDB для обеих задач, поскольку она достаточно гибкая и может работать как с полуструктурированными данными (лендинги), так и с более структурированными (CRM). Однако если требуется высокая производительность на сложных запросах и отчетности, можно использовать PostgreSQL для CRM, поскольку оно поддерживает сложные аналитические запросы.

1.3 - SQLite или MySQL. Почему: Оба варианта обеспечивают простоту и доступность. Для небольших объемов данных (например, обучение и корпоративные нормы) SQLite вполне достаточна. MySQL может подойти для более крупных проектов, где необходимо обеспечивать масштабируемость и доступность.

1.3* - Да, можно использовать ту же СУБД, что и для финансовых данных (например, PostgreSQL или MySQL), если они обеспечивают нужную структуру для хранения и извлечения данных. Для этой задачи можно использовать таблицы и индексы, чтобы быстро находить нужные материалы.

1.4* - PostgreSQL с PostGIS (расширение для работы с геоданными) Почему: PostgreSQL с расширением PostGIS позволяет эффективно работать с географическими данными (маршруты, карты), а также быстро обрабатывать связи между объектами (например, курьеры и объекты доставки). Neo4j, в свою очередь, — это графовая база данных, которая идеально подходит для работы с данными, имеющими сложные взаимосвязи, как в логистике.

1.5* - PostgreSQL с расширениями. Почему: PostgreSQL — это универсальная реляционная СУБД, которая поддерживает как традиционные реляционные операции, так и расширения для работы с геоданными (PostGIS), временем (TimescaleDB), а также имеет возможность работы с неструктурированными данными через JSON.

**Задание 2**   

```
Задание 2. Транзакции  
2.1. Пользователь пополняет баланс счёта телефона, распишите пошагово, какие действия должны произойти для того, чтобы транзакция завершилась успешно. Ориентируйтесь на шесть действий.  

2.1.* Какие действия должны произойти, если пополнение счёта телефона происходило бы через автоплатёж?  

Приведите ответ в свободной форме.  
``` 
**Ответ**    

2.1  
**1. Пользователь инициирует оплату**     
— На сайте, в приложении или в терминале пользователь выбирает оператора и вводит номер телефона, сумму пополнения, способ оплаты (например, банковская карта).  
**2. Проверка и резервирование средств на платёжном средстве**
— Система платёжного шлюза (эквайера) проверяет корректность данных карты, доступность суммы и временно блокирует (резервирует) нужную сумму.  
**3. Передача данных в биллинг мобильного оператора**
— Платёжная система формирует запрос на пополнение баланса и отправляет его в систему оператора мобильной связи.  
**4. Подтверждение приёма транзакции со стороны оператора**
— Оператор проверяет корректность номера телефона и подтверждает готовность принять пополнение.  
**5. Списание зарезервированных средств**
— После подтверждения от оператора платёжная система окончательно списывает средства с карты пользователя и отправляет их на счёт оператора.  
**6. Зачисление средств на счёт абонента и уведомление**
— Мобильный оператор зачисляет сумму на счёт телефона пользователя и отправляет подтверждение (SMS, push-уведомление), а платёжная система показывает сообщение об успешной операции.

2.1.* -

**Задание 3**  

```
Задание 3. SQL vs NoSQL  
3.1. Напишите пять преимуществ SQL-систем по отношению к NoSQL.  

3.1.* Какие, на ваш взгляд, преимущества у NewSQL систем перед SQL и NoSQL.  

Приведите ответ в свободной форме.   

```

**Ответ**  
3.1 
1. Строгая структура и целостность данных (схема)
2. Поддержка сложных запросов и анализа (SQL-язык)
3. Соответствие ACID-принципам
4. Распространённость, зрелость и инструментарий
5. Надёжность при работе с транзакциями и отношениями

3.1.* -

**Задание 4**  

```
Задание 4. Кластеры  
Необходимо производить большое количество вычислений при работе с огромным количеством данных, под эту задачу выделено 1000 машин.  

На основе какого критерия будете выбирать тип СУБД и какая модель распределённых вычислений здесь справится лучше всего и почему?  

Приведите ответ в свободной форме.  

```

**Ответ**  
4. Тип СУБД выбирается в зависимости от структуры данных и требований к консистентности. 
Оптимальная модель вычислений — Apache Spark, как наиболее гибкая, быстрая и масштабируемая платформа для работы с большими объёмами данных на 1000+ машин.
Поддерживает in-memory обработку — быстрее, чем традиционные MapReduce-системы.

Масштабируется на кластерах до тысяч узлов.

Имеет модули для:

- SQL-запросов (Spark SQL),

- машинного обучения (MLlib),

- графов (GraphX),

- обработки потоков (Spark Streaming).

- Работает с различными источниками данных — HDFS, S3, Cassandra, HBase, Hive и др.
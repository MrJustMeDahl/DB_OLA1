# Brugen af SQL programmering

I følgende fil vil vi kort beskrive tankerne bag programmering i SQL og hvilke fordele og ulemper vi har oplevet.

### Fordele

SQL kan være super smart, hvis man bruger det korrekt og implementerer gode kodestykker.
Det kan være nyttigt i firmaer, hvor man benytter mange forskellige platforme til den samme database, da man kan lave stored procedures og functions, der sikrer ensartet datahåndtering og behandling på tværs af systemer. Dette skaber en mere robust arkitektur, hvor logikken kan placeres direkte i databasen i stedet for i den enkelte applikation.
Derudover kan SQL-forespørgsler være optimeret til at håndtere store mængder data hurtigt, især hvis man anvender korrekt indeksering og normalisering.

### Ulemper

SQL kan som sprog være et stort spring nedad ift. programmeringslogik, især for udviklere, da vi er vant til funktionelle eller objektorienterede sprog som Java eller C#. SQL, som er deklarativt, hvor man beskriver, hvad man vil have i stedet for at definere, hvordan det skal udføres, kan føles uintuitivt at arbejde med.

Derudover kan stored procedures og triggers blive svære at debugge, da de ofte kører direkte i databasen og kan være mindre gennemsigtige end kode i et almindeligt programmeringssprog. Kompleks SQL-logik kan også gøre systemet mindre fleksibelt, hvis meget af forretningslogikken bliver låst fast i databasen i stedet for i applikationerne.

Endelig kræver optimering af SQL-forespørgsler forståelse af indekser, joins og caching, hvilket kan være en udfordring for mindre erfarne udviklere. Hvis databasen ikke er designet korrekt fra starten, kan man hurtigt opleve performanceproblemer, især ved store datamængder.

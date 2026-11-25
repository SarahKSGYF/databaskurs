Sarah Björk

Jag har valt att göra en databas för ordrar för målning av spelfigurer.

För kund tabellen har jag valt att ha med ID för primärnyckel, Namn på kunden, Epost, telefon nummer och antalet beställningar den kunden har gjort.
ID, namn och epost får inte vara NULL då de är viktig information som krävs.
Telefonnummer kan vara NULL då det inte är en tvång för identitet.
Eposten är även unik då vi inte vill skapa flera konton för samma person då namn har en tendens att finnas flera personer med samma.

För modellen/produkten så har jag valt att ha med ID för primärnyckel, Namn på modellen, Storlek, vilket material den är gjord av och pris.
Samtliga i denna tabell kan inte vara NULL då är alla viktiga för information och funktion.
Namn är unik här för att inte ha dubbletter.
Har även satt in en check på pris så att man inte råkar sätta in något för gratis eller negativt pris.

Sedan har jag en tabell för ordrar där jag har CommID Primär, Datum, notis och främmandenycklar från CostumerID och ModelD.
Samtlige förutom notis är NULL.
Datum är en automatisk current_timestamp för att logga när orden kommer in.
Notis kan vara NULL då det är ett fällt för kommentarer för kunden att göra med vad de vill ha för färger etc.
främmandenycklarna används för att knyta ihop ordern med en kund och vilken modell de vill ha målad


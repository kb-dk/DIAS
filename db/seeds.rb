# encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

instituter = [{title: 'Antropologi'},
              {title: 'Arabisk'},
              {title: 'Assyriologi'},
              {title: 'Audiologopædi'},
              {title: 'Balkanstudier'},
              {title: 'Biokemi'},
              {title: 'Biologi'},
              {title: 'Biologi-bioteknologi'},
              {title: 'Dansk'},
              {title: 'Datalogi'},
              {title: 'Engelsk'},
              {title: 'Eskimologi'},
              {title: 'Europæisk etnologi'},
              {title: 'Farmaci'},
              {title: 'Film- og medievidenskab'},
              {title: 'Filosofi'},
              {title: 'Finsk'},
              {title: 'Folkesundhedsvidenskab'},
              {title: 'Forhistorisk arkæologi'},
              {title: 'Forsikringsmatematik'},
              {title: 'Fransk sprog, litteratur og kultur'},
              {title: 'Fysiske fag'},
              {title: 'Fødevarer og ernæring'},
              {title: 'Geografi og geoinformatik'},
              {title: 'Geologi-geoscience'},
              {title: 'Grækenlandsstudier'},
              {title: 'Græsk, klassisk'},
              {title: 'Hebraisk'},
              {title: 'Historie'},
              {title: 'Husdyrvidenskab'},
              {title: 'Idræt'},
              {title: 'Indianske sprog og kulturer'},
              {title: 'Indologi'},
              {title: 'Indoeuropæisk'},
              {title: 'Indonesisk/sydøstasienstudier'},
              {title: 'It og sundhed'},
              {title: 'Italiensk'},
              {title: 'Japanstudier'},
              {title: 'Jordbrugsøkonomi'},
              {title: 'Jura'},
              {title: 'Kemi'},
              {title: 'Kinastudier'},
              {title: 'Klassisk arkæologi'},
              {title: 'Kommunikation og it'},
              {title: 'Koreastudier'},
              {title: 'Kunsthistorie'},
              {title: 'Landskabsarkitektur'},
              {title: 'Latin'},
              {title: 'Lingvistik'},
              {title: 'Litteraturvidenskab'},
              {title: 'Matematik'},
              {title: 'Matematik-økonomi'},
              {title: 'Medicin'},
              {title: 'Medicin og teknologi'},
              {title: 'Moderne Indien og Sydasienstudier'},
              {title: 'Molekylær biomedicin'},
              {title: 'Musikvidenskab'},
              {title: 'Nanoscience'},
              {title: 'Naturressourcer'},
              {title: 'Naturvidenskab og it'},
              {title: 'Nederlandsk'},
              {title: 'Nærorientalsk arkæologi'},
              {title: 'Odontologi'},
              {title: 'Persisk'},
              {title: 'Polsk'},
              {title: 'Portugisiske og brasilianske studier'},
              {title: 'Psykologi'},
              {title: 'Pædagogik'},
              {title: 'Religionsvidenskab'},
              {title: 'Retorik'},
              {title: 'Russisk'},
              {title: 'Skov- og landskabsingeniør'},
              {title: 'Sociologi'},
              {title: 'Spansk sprog og kultur'},
              {title: 'Statskundskab/samfundsfag'},
              {title: 'Tandplejer'},
              {title: 'Teatervidenskab'},
              {title: 'Teologi'},
              {title: 'Thai/sydøstasienstudier'},
              {title: 'Tibetologi'},
              {title: 'Tysk'},
              {title: 'Veterinærmedicin'},
              {title: 'Ægyptologi'},
              {title: 'Økonomi'}]


instituter.each do |institut|
  Institute.find_or_create_by_title(institut)
end

sprog = [{title: 'Dansk'},
         {title: 'Engelsk'},
         {title: 'Svensk'},
         {title: 'Norsk'},
         {title: 'Tysk'},
         {title: 'Fransk'},
         {title: 'Spansk'},
         {title: 'Andet'}]

# dansk, engelsk, svensk, norsk, tysk, fransk, spansk, andet



sprog.each do |etsprog|
  PaperLanguage.find_or_create_by_title(etsprog)
end

opgavetyper = [{title: 'Bacheloropgave'},
               {title: 'Case'},
               {title: 'Eksamensopgave'},
               {title: 'Rapport'},
               {title: 'Skriveøvelse'},
               {title: 'Større skriftlig opgave'},
               {title: 'Øvelsesopgave'},
               {title: 'Øvelsesrapport'}]


opgavetyper.each do |enopgavetype|
  PaperType.find_or_create_by_title(enopgavetype)
end



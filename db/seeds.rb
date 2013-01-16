# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

instituter = [{title: 'Antropologi'},
              {title: 'Asienstudier (indologi)'},
              {title: 'Biokemi'       },
              {title: 'Biologi'        },
              {title: 'Biologi-bioteknologi'   },
              {title: 'Dansk'          },
              {title: 'Datalogi'    },
              {title: 'Engelsk'       },
              {title: 'Eskimologi'      },

              {title: 'Farmaci'        },
              {title: 'Film- og medievidenskab'  },
              {title: 'Filosofi'         },
              {title: 'Finsk'  },
              {title: 'Folkesundhedsvidenskab'  },

              {title: 'Forsikringsmatematik'     },
              {title: 'Fransk sprog, litteratur og kultur'},
              {title: 'Fysiske fag'      },

              {title: 'Geografi og geoinformatik'  },
              {title: 'Geologi-geoscience' },

              {title: 'Historie' },
              {title: 'Husdyrvidenskab'},

              {title: 'Indianske sprog og kulturer' },

              {title: 'It og sundhed'  },
              {title: 'Italiensk'    },

              {title: 'Jura' },
              {title: 'Kemi'  },

              {title: 'Kommunikation og it' },
              {title: 'Kunsthistorie'},
              {title: 'Landskabsarkitektur' },
              {title: 'Latin'   },
              {title: 'Lingvistik'    },
              {title: 'Litteraturvidenskab'   },
              {title: 'Matematik'  },

              {title: 'Medicin' }]


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
               {title: 'Synopsis'},
               {title: 'Afleveringsopgave'} ]


opgavetyper.each do |enopgavetype|
  PaperType.find_or_create_by_title(enopgavetype)
end



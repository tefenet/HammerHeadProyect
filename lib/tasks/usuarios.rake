namespace :usuarios do
  desc "TODO"
  task seed_users: :environment do
    User.create!([
     {first_name: "manuel",
      last_name: "benitez",
      email: "manuel@mail.com",
      birth_date: Date.new(1984, 1, 27),
      password: "123456"      },
      {first_name: "raul",
       last_name: "juarez",
       email: "raul@mail.com",
       birth_date: Date.new(1984, 1, 27),
       password: "123456"      },
       {first_name: "daniel",
        last_name: "perez",
        email: "daniel@mail.com",
        birth_date: Date.new(1984, 1, 27),
        password: "123456"      },
        {first_name: "sebastian",
         last_name: "bertora",
         email: "seba@mail.com",
         birth_date: Date.new(1984, 1, 27),
         password: "123456"      }
    ])
  end
  task seed_cars: :environment do
      u1=User.find_by_first_name("manuel")
    a=u1.cars.build(
      :plate=>"NBH344",
      :seats=>3,
      :brand=>"ford",
      :model=>"taunus"
    )
    a1=u1.cards.new(:numero=>8582858285828582,:numeroSeguridad=>987,:vencimiento=>Date.new(2020,1,20))
    u2=User.find_by_first_name("raul")
    b=u2.cars.build(
      :plate=>"NBH345",
      :seats=>5,
      :brand=>"suzuki",
      :model=>"vitara"
    )
    b1=u2.cards.new(:numero=>1582858285828582,:numeroSeguridad=>987,:vencimiento=>Date.new(2018,8,10))
    u3=User.find_by_first_name("daniel")
    c=u3.cars.build(
      :plate=>"NBH346",
      :seats=>2,
      :brand=>"ford",
      :model=>"ka"
    )
    c1=u3.cards.new(:numero=>8582858285828583,:numeroSeguridad=>987,:vencimiento=>Date.new(2020,1,20))
    u4=User.find_by_first_name("sebastian")
    d=u4.cars.build(
      :plate=>"NBH347",
      :seats=>4,
      :brand=>"chevrolet",
      :model=>"corsa"
    )
    d1=u4.cards.new(:numero=>6582858285828582,:numeroSeguridad=>987,:vencimiento=>Date.new(2020,1,20))
    a.save
    a1.save
    b.save
    b1.save
    c.save
    c1.save
    d.save
    d1.save
  end

  task seed_viajes: :environment do
    a=User.find_by_first_name("manuel").viajesComoChofer.build(
      :origen=>"la plata",
      :destino=>"villa elisa",
      :fecha=>Date.new(2018, 4, 27),
      :hora=> Time.new.midday,
      :precio=>200,
      :duracion=>3,
      :descripcion=>"ninguna",
      :car_id=>User.find_by_first_name("manuel").cars.first.id)
      auto=Car.find(a.car_id)
      a.car = auto
      a.asientos_libres = auto.seats
      a.car_plate= auto.plate
      auto.viajes<<a
      a.save
    end
end

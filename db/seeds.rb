# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Product.delete_all
Product.create!(title: 'Binary Romance',
  description: 
    %{<p>
       Doubt is not a pleasant condition, but certainty is absurd.
       The absurd is the essential concept and the first truth.
      </p>},
  image_url:   'bad_web.jpg',    
  price: 46.00)
# . . .
Product.create!(title: 'Mr.President',
  description:
    %{<p>
        Barack Obama and Ed Markey walk into a bar … and nothing happens. 
        Obama can’t decide what he wants, and Markey keeps saying “I’ll have what he’s having.”
      </p>},
  image_url: 'obama_love.jpg',
  price: 49.95)
# . . .

Product.create!(title: 'No Prescriptions',
  description: 
    %{<p>
        I drew this inspired by the famous poster.  
        The black spot on the heart means so much more to me. 
        The continuity is broken a part of my heart is never
         going to be the same again. I used to think about it all 
         the time when i lived in New York. Milton Glaser created a modified version to commemorate the attacks, 
        reading<em>I Love NY More Than Ever</em>with a little black spot on the
         heart symbolizing the World Trade Center site.
        theoretical perspective (why to test) and from a practical perspective.
      </p>},
  image_url: 'nyilu.jpg',
  price: 34.95)

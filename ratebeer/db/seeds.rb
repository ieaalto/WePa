b1 = Brewery.create name:"Koff",year:1897
b2 = Brewery.create name:"Malmgard",year:2001
b3 = Brewery.create name:"Weihenstephaner",year:1042

s1 = Style.create name:"Lager"
s2 = Style.create name:"Pale Ale"
s3 = Style.create name:"Porter"
s4 = Style.create name:"Weizen"

br1 = b1.beers.create name:"Iso 3", style_id: s1.id
br2 = b1.beers.create name:"Karhu", style_id: s1.id
br3 = b1.beers.create name:"Tuplahumala", style_id: s1.id
br4 = b2.beers.create name:"Huvila Pale Ale", style_id: s2.id
br5 = b2.beers.create name:"X Porter", style_id: s3.id
br6 = b3.beers.create name:"Hefenzeizen", style_id: s4.id
br7 = b3.beers.create name:"Helles", style_id: s1.id

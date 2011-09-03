def r()
  flow( :margin => 5 ) do
  background( lightyellow, :curve => 10 )
    para( 'aaaa' )
    l = link( 'b' * 10 ){}
    c = "\n"
    c += 'ccccc ' * 20
    para( l, c )
  end
end

Shoes.app() do
  background darkgray
  r()
  r()
end

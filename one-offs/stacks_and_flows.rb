def r()
  flow( :margin => 5 ) do
    background( lightyellow, :curve => 10 )
    # FIXME:  This doesn't actually work.  Proof:
    #para( "aaaa\naaaa\naaaa\naaaa\naaaa\n" )
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

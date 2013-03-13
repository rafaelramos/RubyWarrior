class Player
  def play_turn(warrior)
    # add your code here
	if prisioneroBomba?(warrior) != false
		if warrior.feel(prisioneroBomba?(warrior)).empty?||warrior.feel(prisioneroBomba?(warrior)).ticking?
			if warrior.feel(prisioneroBomba?(warrior)).ticking?
				warrior.rescue!(prisioneroBomba?(warrior))
			else
				if warrior.health < 7
					warrior.rest!
				else
					warrior.walk!(prisioneroBomba?(warrior))
				end
			end
		elsif evadir?(warrior,prisioneroBomba?(warrior))!= false
			warrior.walk!(evadir?(warrior,prisioneroBomba?(warrior)))
		elsif enemigosAlrededor?(warrior) > 1
			if warrior.feel(:forward).enemy? && (prisioneroBomba?(warrior) != :forward)
				warrior.bind!(:forward)
			elsif warrior.feel(:backward).enemy? && (prisioneroBomba?(warrior) != :backward)
				warrior.bind!(:backward)
			elsif warrior.feel(:right).enemy? && (prisioneroBomba?(warrior) != :right)
				warrior.bind!(:right)
			elsif warrior.feel(:left).enemy? && (prisioneroBomba?(warrior) != :left)
				warrior.bind!(:left)
			end
		else
			if warrior.look(prisioneroBomba?(warrior))[0].enemy? && warrior.look(prisioneroBomba?(warrior))[1].enemy? && warrior.health>6
				warrior.detonate!(prisioneroBomba?(warrior))
			else
				warrior.attack!(prisioneroBomba?(warrior))
			end
		end	
	elsif enemigosAlrededor?(warrior) > 1
		warrior.bind!(enemigoAlLado?(warrior))
	elsif enemigosAlrededor?(warrior) == 1
		warrior.attack!(enemigoAlLado?(warrior))
	elsif warrior.health < 20
		warrior.rest!
	elsif prisioneroAlLado?(warrior) != false
		warrior.rescue!(prisioneroAlLado?(warrior))
	elsif enemigosEnLaSala?(warrior) != false
		if warrior.feel(enemigosEnLaSala?(warrior)).empty?
			warrior.walk!(enemigosEnLaSala?(warrior))
		else
			warrior.walk!(evadir?(warrior,enemigosEnLaSala?(warrior)))
		end
	elsif prisionerosEnLaSala?(warrior) != false
		if warrior.feel(prisionerosEnLaSala?(warrior)).empty?
			warrior.walk!(prisionerosEnLaSala?(warrior))
		else
			warrior.walk!(evadir?(warrior,prisionerosEnLaSala?(warrior)))
		end
	else
		warrior.walk!(warrior.direction_of_stairs)
	end
  end
    
  #Prisionero bomba?
  def prisioneroBomba?(warrior)
	prisioneros = warrior.listen
	prisioneros.each do |p|
		if p.captive? && p.ticking?
			return warrior.direction_of(p)
		end
	end
	return false
  end
  #Evadir?
  def evadir?(warrior, direction)
	if direction == :forward
		if warrior.feel(:right).empty?
			return :right
		elsif warrior.feel(:left).empty?
			return :left
		else
			return false
		end
	elsif direction == :right
		if warrior.feel(:forward).empty?
			return :forward
		#elsif warrior.feel(:backward).empty?
		#	return :backward
		else
			return false
		end
	elsif direction == :backward
		if warrior.feel(:left).empty?
			return :left
		elsif warrior.feel(:right).empty?
			return :right
		else
			return false
		end
	elsif direction == :left
		#if warrior.feel(:backward).empty?
		#	return :backward
		if warrior.feel(:forward).empty? 
			return :forward
		else
			return false
		end
	end
  end
  #Enemigos en la sala?
  def enemigosEnLaSala?(warrior)
	enemigos = warrior.listen
	enemigos.each do |p|
		if p.enemy?
			return warrior.direction_of(p)
		end
	end
	return false
  end
  #Prisioneros en la sala?
  def prisionerosEnLaSala?(warrior)
	prisioneros = warrior.listen
	prisioneros.each do |p|
		if p.captive?
			return warrior.direction_of(p)
		end
	end
	return false
  end
  #Enemigos alrededor?
  def enemigosAlrededor?(warrior)
	enemigos = 0
	if warrior.feel.enemy?
		enemigos += 1
	end
	if warrior.feel(:backward).enemy?
		enemigos += 1
	end
	if warrior.feel(:right).enemy?
		enemigos += 1
	end
	if warrior.feel(:left).enemy?
		enemigos += 1
	end
	return enemigos
  end
  #Enemigo al lado?
  def enemigoAlLado?(warrior)
	if warrior.feel.enemy?
		return (:forward)
	elsif warrior.feel(:backward).enemy?
		return (:backward)
	elsif warrior.feel(:right).enemy?
		return (:right)
	elsif warrior.feel(:left).enemy?
		return (:left)
	else
		false
	end
  end
  #Prisionero al lado
  def prisioneroAlLado?(warrior)
	if warrior.feel.captive?
		return (:forward)
	elsif warrior.feel(:backward).captive?
		return (:backward)
	elsif warrior.feel(:right).captive?
		return (:right)
	elsif warrior.feel(:left).captive?
		return (:left)
	else
		false
	end
  end
  #direccion contraria
  def direccionlibre? (warrior, direccion)
	if direccion == :forward
		if warrior.feel(:backward).empty?
			return :backward
		elsif warrior.feel(:right).empty?
			return :right
		elsif warrior.feel(:left).empty?
			return :left
		else
			return false
		end
	elsif direccion == :backward
		if warrior.feel(:forward).empty?
			return :forward
		elsif warrior.feel(:right).empty?
			return :right
		elsif warrior.feel(:left).empty?
			return :left
		else
			return false
		end
	elsif direccion == :right
		if warrior.feel(:backward).empty?
			return :backward
		elsif warrior.feel(:forward).empty?
			return :forward
		elsif warrior.feel(:left).empty?
			return :left
		else
			return false
		end
	elsif direccion == :left
		if warrior.feel(:backward).empty?
			return :backward
		elsif warrior.feel(:right).empty?
			return :right
		elsif warrior.feel(:forward).empty?
			return :forward
		else
			return false
		end
	end
  end
  
end

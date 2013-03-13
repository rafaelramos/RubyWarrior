class Player
  def play_turn(warrior)
    # add your code here
	@Health
	@Adelante = warrior.look
	@Atras = warrior.look(:backward)
	@FirstAdelante
	@FirstAtras
	#Si es la primera ejecución asigno los valores por default
	if @Health.nil?
		@Health = warrior.health
	end
	#Detecto si hay algo alfrente
	if warrior.feel.empty?
		#Reviso la primer cosa que haya adelante y atras
		#Adelante
		if @Adelante[0].to_s != "nothing"
			@FirstAdelante = @Adelante[0].to_s
		elsif @Adelante[1].to_s != "nothing"
			@FirstAdelante = @Adelante[1].to_s
		elsif @Adelante[2].to_s != "nothing"
			@FirstAdelante = @Adelante[2].to_s
		else
			@FirstAdelante = "nothing"
		end
		
		#Atras
		if @Atras[0].to_s != "nothing"
			@FirstAtras = @Atras[0].to_s
		elsif @Atras[1].to_s != "nothing"
			@FirstAtras = @Atras[1].to_s
		elsif @Atras[2].to_s != "nothing"
			@FirstAtras = @Atras[2].to_s
		else
			@FirstAtras = "nothing"
		end
		
		#Si es un mago lo mato, si es arquero lo mato, si no sigo avanzando
		if @FirstAdelante == "Wizard"
			warrior.shoot!
		elsif @FirstAtras == "Wizard"
			warrior.shoot!(:backward)
		elsif @FirstAdelante == "Archer"
			warrior.shoot!
		elsif @FirstAtras == "Archer"
			warrior.shoot!(:backward)		
		elsif @FirstAtras == "Captive"
			warrior.pivot!(:backward)		
		#Detecto si pierdo vida
		elsif warrior.health < @Health
			if warrior.health < 12
				warrior.walk!(:backward)
			else
				warrior.walk!
			end
		else
			#No pierdo vida, ahora me recupero o camino
			if warrior.health < 20
				warrior.rest!
			else
				warrior.walk!
			end
		end
	#Hay algo alfrente
	else
		#Si es rehen rescato, si es un muro me doy vuelta, si no ataco
		if warrior.feel.captive?
			warrior.rescue!
		elsif warrior.feel.wall?
			warrior.pivot!(:backward)
		else
			warrior.attack!
		end
	end
	@Health = warrior.health
  end
end

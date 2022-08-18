function start()

    P_INIT; % assumed sea level pressure at the equator %
    TEMP_SEA_LEVEL = 294; % assumed sea level air temperature at the equator at sunrise %
    M_ATM = 0.0290; % assumed molar mass of earth's atmosphere in Kg/mole %
    R = 8.31; % gas constant in J / (K * mole) %
    g = 9.79; % assumed gravity at the equator. We will treat this as a constant% 
    
    atlas_booster_mass = 21351; % mass of main fuel tank and RD-180 engine %
    rocket_booster_mass = 46697; % mass of individual solid rocket boosters in kg %
    fuel_mass;
    payload_mass;
    payload_fairing_enclosed_mass = %number + payload_mass %; % this includes everything within the payload fairing including payload and the centaur %
    total_current_mass;
    
    atlas_booster_thrust_atm = 3827; % thrust of main atlas booster in the atmosphere in kN. We are assuming this is constant and not accounting for atmospheric pressure %
    atlas_booster_thrust_vac = 4152; % thrust in a vacuum %
    rocket_booster_thrust = 1688.4; % these are discarded before space is reached so only one value for thrust is necessary %
    current_wind_res; % calculated current resistance due to atmosphere in kN %
    
    t = 0;
    t_increment = 0.5;
    t_rocket_booster_detach;
    t_falcon_booster_detach;
    t_end_sim;
    p_current; % pressure at current altitude %
    current_alt = 0;
   
    while(t < tEnd)
    % work out resistive force be using velocity from last iteration % 
    t = t + t_increment; 
        
    end
end
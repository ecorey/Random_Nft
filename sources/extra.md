//     let divine_shield = mint_divine_shield(ctx);
    //     let divine_shield_two = mint_divine_shield(ctx);
        
    //     let last_stand = mint_last_stand(ctx);
    //     let last_stand_two = mint_last_stand(ctx);
        
    //     let massive_onslaught = mint_massive_onslaught(ctx);
    //     let massive_onslaught_two = mint_massive_onslaught(ctx);

    //     let battle_cry = mint_battle_cry(ctx);
    //     let battle_cry_two = mint_battle_cry(ctx);

    //     let decisive_strike = mint_decisive_strike(ctx);
    //     let decisive_strike_two = mint_decisive_strike(ctx);

    //     let shield_bash = mint_shield_bash(ctx);
    //     let shield_bash_two = mint_shield_bash(ctx);

    //     let boost_attack = mint_boost_attack(ctx);
    //     let boost_attack_two = mint_boost_attack(ctx);

    //     let fortify_defense = mint_fortify_defense(ctx);
    //     let fortify_defense_two = mint_fortify_defense(ctx);

    //     let vitality_surge = mint_vitality_surge(ctx);
    //     let vitality_surge_two = mint_vitality_surge(ctx);

    //     let ambush = mint_ambush(ctx);
    //     let ambush_two = mint_ambush(ctx);

    //     let quick_retreat = mint_quick_retreat(ctx);
    //     let quick_retreat_two = mint_quick_retreat(ctx);

    //     let reinforcements = mint_reinforcements(ctx);
    //     let reinforcements_two = mint_reinforcements(ctx);

    //     let peace_treaty = mint_peace_treaty(ctx);
    //     let peace_treaty_two = mint_peace_treaty(ctx);

    //     let sabotage = mint_sabotage(ctx);
    //     let sabotage_two = mint_sabotage(ctx);

    //     let war_drums = mint_war_drums(ctx);
    //     let war_drums_two = mint_war_drums(ctx);

    //     let espionage = mint_espionage(ctx);
    //     let espionage_two = mint_espionage(ctx);

    //     let regroup = mint_regroup(ctx);
    //     let regroup_two = mint_regroup(ctx);

    //     let scout = mint_scout(ctx);
    //     let scout_two = mint_scout(ctx);




    //     let divine_shield_vector = vector::empty<DivineShield>();
    //     vector::push_back(&mut divine_shield_vector, divine_shield);
    //     vector::push_back(&mut divine_shield_vector, divine_shield_two);


    //     let last_stand_vector = vector::empty<LastStand>();
    //     vector::push_back(&mut last_stand_vector, last_stand);
    //     vector::push_back(&mut last_stand_vector, last_stand_two);


    //     let massive_onslaught_vector = vector::empty<MassiveOnslaught>();
    //     vector::push_back(&mut massive_onslaught_vector, massive_onslaught);
    //     vector::push_back(&mut massive_onslaught_vector, massive_onslaught_two);


    //     let battle_cry_vector = vector::empty<BattleCry>();
    //     vector::push_back(&mut battle_cry_vector, battle_cry);
    //     vector::push_back(&mut battle_cry_vector, battle_cry_two);


    //     let decisive_strike_vector = vector::empty<DecisiveStrike>();
    //     vector::push_back(&mut decisive_strike_vector, decisive_strike);
    //     vector::push_back(&mut decisive_strike_vector, decisive_strike_two);


    //     let shield_bash_vector = vector::empty<ShieldBash>();
    //     vector::push_back(&mut shield_bash_vector, shield_bash);
    //     vector::push_back(&mut shield_bash_vector, shield_bash_two);


    //     let boost_attack_vector = vector::empty<BoostAttack>();
    //     vector::push_back(&mut boost_attack_vector, boost_attack);
    //     vector::push_back(&mut boost_attack_vector, boost_attack_two);


    //     let fortify_defense_vector = vector::empty<FortifyDefense>();
    //     vector::push_back(&mut fortify_defense_vector, fortify_defense);
    //     vector::push_back(&mut fortify_defense_vector, fortify_defense_two);


    //     let vitality_surge_vector = vector::empty<VitalitySurge>();
    //     vector::push_back(&mut vitality_surge_vector, vitality_surge);
    //     vector::push_back(&mut vitality_surge_vector, vitality_surge_two);



    //     let ambush_vector = vector::empty<Ambush>();
    //     vector::push_back(&mut ambush_vector, ambush);
    //     vector::push_back(&mut ambush_vector, ambush_two);


    //     let quick_retreat_vector = vector::empty<QuickRetreat>();
    //     vector::push_back(&mut quick_retreat_vector, quick_retreat);
    //     vector::push_back(&mut quick_retreat_vector, quick_retreat_two);


    //     let reinforcements_vector = vector::empty<Reinforcements>();
    //     vector::push_back(&mut reinforcements_vector, reinforcements);
    //     vector::push_back(&mut reinforcements_vector, reinforcements_two);


    //     let peace_treaty_vector = vector::empty<PeaceTreaty>();
    //     vector::push_back(&mut peace_treaty_vector, peace_treaty);
    //     vector::push_back(&mut peace_treaty_vector, peace_treaty_two);


    //     let sabotage_vector = vector::empty<Sabotage>();
    //     vector::push_back(&mut sabotage_vector, sabotage);
    //     vector::push_back(&mut sabotage_vector, sabotage_two);


    //     let war_drums_vector = vector::empty<WarDrums>();
    //     vector::push_back(&mut war_drums_vector, war_drums);
    //     vector::push_back(&mut war_drums_vector, war_drums_two);


    //     let espionage_vector = vector::empty<Espionage>();
    //     vector::push_back(&mut espionage_vector, espionage);
    //     vector::push_back(&mut espionage_vector, espionage_two);


    //     let regroup_vector = vector::empty<Regroup>();
    //     vector::push_back(&mut regroup_vector, regroup);
    //     vector::push_back(&mut regroup_vector, regroup_two);


    //     let scout_vector = vector::empty<Scout>();
    //     vector::push_back(&mut scout_vector, scout);
    //     vector::push_back(&mut scout_vector, scout_two);



        
    //     // let gnome_deck = GnomeDeck {

    //     //     id: object::new(ctx),
            

    //     // };

    //     main_deck_cards




public fun delete_gnome_general_vector(deck: vector<GnomeGeneral>) {

        
       while (!vector::is_empty(&mut deck)) {
            let card = vector::pop_back(&mut deck);
            delete_gnome_general(card);
        };

        vector::destroy_empty(deck);

    }





 // divne_shield,
            // last_stand,
            // massive_onslaught,
            // battle_cry,
            // decisive_strike,
            // shield_bash,
            // boost_attack,
            // fortify_defense,
            // vitality_surge,
            // ambush,
            // quick_retreat,
            // reinforcements,
            // peace_treaty,
            // sabotage,
            // war_drums,
            // espionage,
            // regroup,
            // scout,
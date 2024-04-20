#[test_only]
module capy_vs_gnome::more_card_tests {


    use sui::test_scenario;
    use sui::test_utils::{create_one_time_witness, assert_eq};
    use std::debug;
    use sui::tx_context::{Self, TxContext};
    // use capy_vs_gnome::card_deck::{mint_gnome_deck, mint_capy_deck};
    use capy_vs_gnome::card_deck::{delete_gnome_general, delete_gnome_monster, delete_gnome_rider, delete_gnome_soldier, delete_divine_shield, delete_last_stand, delete_massive_onslaught, delete_battle_cry, delete_decisive_strike, delete_shield_bash, delete_boost_attack, delete_fortify_defense, delete_vitality_surge, delete_ambush, delete_quick_retreat, delete_reinforcements, delete_peace_treaty, delete_sabotage, delete_war_drums, delete_espionage, delete_regroup, delete_scout};
    use capy_vs_gnome::card_deck::{delete_capy_general, delete_capy_monster, delete_capy_rider, delete_capy_soldier};   
    use capy_vs_gnome::card_deck::{CARD_DECK, init_for_testing};
    use capy_vs_gnome::card_deck::{mint_gnome_deck, delete_gnome_deck};
   


    fun init_test_helper() : test_scenario::Scenario {

        let admin = @0xABC;
        let user1 = @0x123;

        let scenario = test_scenario::begin(admin);
        let scenario_val = &mut scenario;

        let otw = create_one_time_witness<CARD_DECK>();


        {
            init_for_testing(otw, test_scenario::ctx(scenario_val));
        };

        scenario



    }



    #[test]
    public fun character_card_tests() {


        let admin = @0xABC;
        let user1 = @0x123;

        let scenario = init_test_helper();
        let scenario_val = &mut scenario;
        let ctx = test_scenario::ctx(scenario_val);


        // Mint gnome deck
        // test_scenario::next_tx(scenario_val, admin);
        // {
            
        //     let (gnome_general, gnome_monster, gnome_rider, gnome_soldier, divine_shield, last_stand, massive_onslaught, battle_cry, decisive_strike, shield_bash, boost_attack, fortify_defense, vitality_surge, ambush, quick_retreat, reinforcements, peace_treaty, sabotage, war_drums, espionage, regroup, scout,
        //     divine_shield2, last_stand2, massive_onslaught2, battle_cry2, decisive_strike2, shield_bash2, boost_attack2, fortify_defense2, vitality_surge2, ambush2, quick_retreat2, reinforcements2, peace_treaty2, sabotage2, war_drums2, espionage2, regroup2, scout2)
        //         = mint_gnome_deck(test_scenario::ctx(scenario_val));



        //     delete_gnome_general(gnome_general);
        //     delete_gnome_monster(gnome_monster);
        //     delete_gnome_rider(gnome_rider);
        //     delete_gnome_soldier(gnome_soldier);
        //     delete_divine_shield(divine_shield);
        //     delete_last_stand(last_stand);
        //     delete_massive_onslaught(massive_onslaught);
        //     delete_battle_cry(battle_cry);
        //     delete_decisive_strike(decisive_strike);
        //     delete_shield_bash(shield_bash);
        //     delete_boost_attack(boost_attack);
        //     delete_fortify_defense(fortify_defense);
        //     delete_vitality_surge(vitality_surge);
        //     delete_ambush(ambush);
        //     delete_quick_retreat(quick_retreat);
        //     delete_reinforcements(reinforcements);
        //     delete_peace_treaty(peace_treaty);
        //     delete_sabotage(sabotage);
        //     delete_war_drums(war_drums);
        //     delete_espionage(espionage);
        //     delete_regroup(regroup);
        //     delete_scout(scout);

        //     delete_divine_shield(divine_shield2);
        //     delete_last_stand(last_stand2);
        //     delete_massive_onslaught(massive_onslaught2);
        //     delete_battle_cry(battle_cry2);
        //     delete_decisive_strike(decisive_strike2);
        //     delete_shield_bash(shield_bash2);
        //     delete_boost_attack(boost_attack2);
        //     delete_fortify_defense(fortify_defense2);
        //     delete_vitality_surge(vitality_surge2);
        //     delete_ambush(ambush2);
        //     delete_quick_retreat(quick_retreat2);
        //     delete_reinforcements(reinforcements2);
        //     delete_peace_treaty(peace_treaty2);
        //     delete_sabotage(sabotage2);
        //     delete_war_drums(war_drums2);
        //     delete_espionage(espionage2);
        //     delete_regroup(regroup2);
        //     delete_scout(scout2);


        // };


        // Test 2
        // test_scenario::next_tx(scenario_val, admin);
        // {
        //     let (capy_general, capy_monster, capy_rider, capy_soldier, divine_shield, last_stand, massive_onslaught, battle_cry, decisive_strike, shield_bash, boost_attack, fortify_defense, vitality_surge, ambush, quick_retreat, reinforcements, peace_treaty, sabotage, war_drums, espionage, regroup, scout,
        //     divine_shield2, last_stand2, massive_onslaught2, battle_cry2, decisive_strike2, shield_bash2, boost_attack2, fortify_defense2, vitality_surge2, ambush2, quick_retreat2, reinforcements2, peace_treaty2, sabotage2, war_drums2, espionage2, regroup2, scout2) 
        //         =  mint_capy_deck(test_scenario::ctx(scenario_val));

        //     delete_capy_general(capy_general);
        //     delete_capy_monster(capy_monster);
        //     delete_capy_rider(capy_rider);
        //     delete_capy_soldier(capy_soldier);
        //     delete_divine_shield(divine_shield);
        //     delete_last_stand(last_stand);
        //     delete_massive_onslaught(massive_onslaught);
        //     delete_battle_cry(battle_cry);
        //     delete_decisive_strike(decisive_strike);
        //     delete_shield_bash(shield_bash);
        //     delete_boost_attack(boost_attack);
        //     delete_fortify_defense(fortify_defense);
        //     delete_vitality_surge(vitality_surge);
        //     delete_ambush(ambush);
        //     delete_quick_retreat(quick_retreat);
        //     delete_reinforcements(reinforcements);
        //     delete_peace_treaty(peace_treaty);
        //     delete_sabotage(sabotage);
        //     delete_war_drums(war_drums);
        //     delete_espionage(espionage);
        //     delete_regroup(regroup);
        //     delete_scout(scout);

        //     delete_divine_shield(divine_shield2);
        //     delete_last_stand(last_stand2);
        //     delete_massive_onslaught(massive_onslaught2);
        //     delete_battle_cry(battle_cry2);
        //     delete_decisive_strike(decisive_strike2);
        //     delete_shield_bash(shield_bash2);
        //     delete_boost_attack(boost_attack2);
        //     delete_fortify_defense(fortify_defense2);
        //     delete_vitality_surge(vitality_surge2);
        //     delete_ambush(ambush2);
        //     delete_quick_retreat(quick_retreat2);
        //     delete_reinforcements(reinforcements2);
        //     delete_peace_treaty(peace_treaty2);
        //     delete_sabotage(sabotage2);
        //     delete_war_drums(war_drums2);
        //     delete_espionage(espionage2);
        //     delete_regroup(regroup2);
        //     delete_scout(scout2);


        // };





        // Test 3
        // Test deck
        test_scenario::next_tx(scenario_val, admin);
        {
            
            let deck = mint_gnome_deck(test_scenario::ctx(scenario_val));
            delete_gnome_deck(deck);

        };





        // Test 4
        // Test game structure
        test_scenario::next_tx(scenario_val, admin);
        {
            
            

        };





        // template
        test_scenario::next_tx(scenario_val, admin);
        {
            
            

        };

















        test_scenario::end(scenario);



    }













}
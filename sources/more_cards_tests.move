#[test_only]
module capy_vs_gnome::more_card_tests {


    use sui::test_scenario;
    use sui::test_utils::{create_one_time_witness, assert_eq};
    use std::debug;
    use std::vector;
    use sui::tx_context::{Self, TxContext};
    use capy_vs_gnome::card_deck::{CARD_DECK, init_for_testing};
    use capy_vs_gnome::card_deck::{mint_gnome_cards, mint_main_deck_cards};
    // use capy_vs_gnome::card_deck::{mint_capy_deck, delete_capy_deck};

    use capy_vs_gnome::card_deck::{delete_gnome_general, delete_gnome_monster, delete_gnome_rider, delete_gnome_soldier};
    use capy_vs_gnome::card_deck::{delete_divine_shield, delete_last_stand, delete_massive_onslaught, delete_battle_cry, delete_decisive_strike, delete_shield_bash, delete_boost_attack, delete_fortify_defense, delete_vitality_surge, delete_ambush, delete_quick_retreat, delete_reinforcements, delete_peace_treaty, delete_sabotage, delete_war_drums, delete_espionage, delete_regroup, delete_scout};

   


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
    public fun character_card_cards() {


        let admin = @0xABC;
        let user1 = @0x123;

        let scenario = init_test_helper();
        let scenario_val = &mut scenario;
        let ctx = test_scenario::ctx(scenario_val);



        
        // TEST DECKS
        // mint gnome deck and delete gnome deck
        test_scenario::next_tx(scenario_val, admin);
        {
            
            let (gnome_general, gnome_monster, gnome_rider, gnome_soldier) = mint_gnome_cards(test_scenario::ctx(scenario_val));

            let (divine_shield, divine_shield_two, last_stand, last_stand_two, massive_onslaught, massive_onslaught_two, battle_cry, battle_cry_two, decisive_strike, decisive_strike_two, shield_bash, shield_bash_two, boost_attack, boost_attack_two, fortify_defense, fortify_defense_two, vitality_surge, vitality_surge_two, ambush, ambush_two, quick_retreat, quick_retreat_two, reinforcements, reinforcements_two, peace_treaty, peace_treaty_two, sabotage, sabotage_two, war_drums, war_drums_two, espionage, espionage_two, regroup, regroup_two, scout, scout_two) = mint_main_deck_cards(test_scenario::ctx(scenario_val));
            


            delete_gnome_general(gnome_general);
            delete_gnome_monster(gnome_monster);
            delete_gnome_rider(gnome_rider);
            delete_gnome_soldier(gnome_soldier);



            delete_divine_shield(divine_shield);
            delete_divine_shield(divine_shield_two);
            delete_last_stand(last_stand);
            delete_last_stand(last_stand_two);
            delete_massive_onslaught(massive_onslaught);
            delete_massive_onslaught(massive_onslaught_two);
            delete_battle_cry(battle_cry);
            delete_battle_cry(battle_cry_two);
            delete_decisive_strike(decisive_strike);
            delete_decisive_strike(decisive_strike_two);
            delete_shield_bash(shield_bash);
            delete_shield_bash(shield_bash_two);
            delete_boost_attack(boost_attack);
            delete_boost_attack(boost_attack_two);
            delete_fortify_defense(fortify_defense);
            delete_fortify_defense(fortify_defense_two);
            delete_vitality_surge(vitality_surge);
            delete_vitality_surge(vitality_surge_two);
            delete_ambush(ambush);
            delete_ambush(ambush_two);
            delete_quick_retreat(quick_retreat);
            delete_quick_retreat(quick_retreat_two);
            delete_reinforcements(reinforcements);
            delete_reinforcements(reinforcements_two);
            delete_peace_treaty(peace_treaty);
            delete_peace_treaty(peace_treaty_two);
            delete_sabotage(sabotage);
            delete_sabotage(sabotage_two);
            delete_war_drums(war_drums);
            delete_war_drums(war_drums_two);
            delete_espionage(espionage);
            delete_espionage(espionage_two);
            delete_regroup(regroup);
            delete_regroup(regroup_two);
            delete_scout(scout);
            delete_scout(scout_two);

            

        };




        // mint capy deck and delete capy deck
        test_scenario::next_tx(scenario_val, admin);
        {
        
            // let deck = mint_capy_deck(test_scenario::ctx(scenario_val));
            // delete_capy_deck(deck);

        };





        // next test
        test_scenario::next_tx(scenario_val, admin);
        {
            
            

        };




        // next test
        test_scenario::next_tx(scenario_val, admin);
        {
            
       

        };





        // next test
        test_scenario::next_tx(scenario_val, admin);
        {
            
            

        };















        test_scenario::end(scenario);



    }













}
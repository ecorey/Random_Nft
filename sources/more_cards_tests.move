#[test_only]
module capy_vs_gnome::more_card_tests {


    use sui::test_scenario;
    use sui::test_utils::{create_one_time_witness, assert_eq};
    use std::debug;
    use sui::tx_context::{Self, TxContext};
    use capy_vs_gnome::card_deck::{mint_gnome_deck};
    use capy_vs_gnome::card_deck::{CARD_DECK, init_for_testing};
   


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
        test_scenario::next_tx(scenario_val, admin);
        {
            
            // let () = mint_gnome_deck();
            
            // let (gnome_general, gnome_monster, gnome_rider, gnome_soldier) = mint_gnome_army(test_scenario::ctx(scenario_val));
            // let (capy_general, capy_monster, capy_rider, capy_soldier) = mint_capy_army(test_scenario::ctx(scenario_val));


            // delete_gnome_general(gnome_general);
            // delete_gnome_monster(gnome_monster);
            // delete_gnome_rider(gnome_rider);
            // delete_gnome_soldier(gnome_soldier);


            // delete_capy_general(capy_general);
            // delete_capy_monster(capy_monster);
            // delete_capy_rider(capy_rider);
            // delete_capy_soldier(capy_soldier);

         

        };


        // Test 2
        test_scenario::next_tx(scenario_val, admin);
        {

        };


        test_scenario::end(scenario);



    }













}
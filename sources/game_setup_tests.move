#[test_only]
module capy_vs_gnome::game_setup_tests {


    use sui::test_scenario;
    use sui::test_utils::{create_one_time_witness, assert_eq};
    use std::debug;
    use std::vector;
    use sui::tx_context::{Self, TxContext};
    use capy_vs_gnome::game_setup::{GAME_SETUP, init_for_testing};
    


   


    fun init_test_helper() : test_scenario::Scenario {

        let admin = @0xABC;
        let user1 = @0x123;

        let scenario = test_scenario::begin(admin);
        let scenario_val = &mut scenario;

        let otw = create_one_time_witness<GAME_SETUP>();


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
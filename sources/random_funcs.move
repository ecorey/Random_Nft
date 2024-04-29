module capy_vs_gnome::random_funcs {


    use sui::tx_context::{Self, TxContext};
    use sui::package::{Self, Publisher};
    use sui::object::{Self, UID, ID};
    use sui::transfer;
    use sui::event;
    use std::string::{utf8, String};



    #[test_only]
    friend capy_vs_gnome::random_funcs_tests;


    use sui::random::{Self, Random, new_generator};
    



    struct RANDOM_FUNCS has drop {}




    fun init(otw: RANDOM_FUNCS, ctx: &mut TxContext) {


    }




    entry fun ten_percent_probability(r: &Random, ctx: &mut TxContext ) : (bool, u8) {

        let result: bool = false;

        let generator = new_generator(r, ctx);
        let v = random::generate_u8_in_range(&mut generator, 1, 100);


        // probability of 10%
        let ten__percent = arithmetic_is_less_than(v, 11, 100); 


        if(ten__percent == 1) {
            result = true;
        };


        (result, ten__percent)

    }





    // Returns 1 if true, 0 false.
    // Safe in case w and v_max are independent of the randomenss (e.g., fixed).
    // Does not check if v <= v_max.
    fun arithmetic_is_less_than(v: u8, w: u8, v_max: u8): u8 {
        assert!(v_max >= w && w > 0, 1);
        let v_max_over_w = v_max / w;
        let v_over_w = v / w; // 0 if v < w, [1, v_max_over_w] if above
        (v_max_over_w - v_over_w) / v_max_over_w
    }










    #[test_only]
    public fun init_for_testing(otw: RANDOM_FUNCS, ctx: &mut TxContext) {
        init(otw, ctx);
    }







}
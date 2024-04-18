module capy_vs_gnome::more_cards {


    use sui::tx_context::{Self, TxContext};
    use sui::package::{Self, Publisher};
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::display::{Self, Display};
    use sui::event;
    use std::string::{utf8, String};

    #[test_only]
    friend capy_vs_gnome::more_card_tests;




    // ----------------------------------------------
    // ONE TIME USE POWER CARDS 
    // ----------------------------------------------


    // DIVINE SHIELD *********************************
    struct DivineShield has key, store {
        id: UID,
        name: String, 
        image_url: String,
    }


    // when card is played it is lost, and the effect is applied to the player's character
    public fun use_divine_shield( divine_shield: DivineShield, ctx: &mut TxContext) {


        // One character is immune to all damage and effects for one turn. (Cost: 5 CP)


        let DivineShield {
            id,
            name: _,
            image_url: _,
        
        } = divine_shield; 

        object::delete(id);

    }


    fun mint_divine_shield(ctx: &mut TxContext) : DivineShield {
        let id = object::new(ctx);

        DivineShield {
            id: id,
            name: utf8(b"divine shield"),
            image_url: utf8(b"ipfs://divine_shield_image_url"),
        }
    }


    
    public fun delete_divine_shield(divine_shield: DivineShield) {
        let DivineShield { id, name: _, image_url: _ } = divine_shield;
        object::delete(id);
    }

    

    // LAST STAND *********************************
    struct LastStand has key, store {
        id: UID,
        name: String, 
        image_url: String,
    }


    // when card is played it is lost, and the effect is applied to the player's character
    public fun use_last_stand( last_stand: LastStand, ctx: &mut TxContext) {


        // For one turn, your characters cannot be reduced below 1 health. (Cost: 5 CP)

        let LastStand {
            id,
            name: _,
            image_url: _,
        
        } = last_stand; 

        object::delete(id);

    }


    fun mint_last_stand(ctx: &mut TxContext) : LastStand {
        let id = object::new(ctx);

        LastStand {
            id: id,
            name: utf8(b"last stand"),
            image_url: utf8(b"ipfs://last_stand_image_url"),
        }
    }


    
    public fun delete_last_stand(last_stand: LastStand) {
        let LastStand { id, name: _, image_url: _ } = last_stand;
        object::delete(id);
    }




    // MASSIVE ONSLAUGHT *********************************
    struct MassiveOnslaught has key, store {
        id: UID,
        name: String, 
        image_url: String,
    }


    // when card is played it is lost, and the effect is applied to the player's character
    public fun use_massive_onslaught( massive_onslaught: MassiveOnslaught, ctx: &mut TxContext) {


        // Your characters gain +3 attack for one turn. (Cost: 5 CP)
        let MassiveOnslaught {
            id,
            name: _,
            image_url: _,
        
        } = massive_onslaught; 

        object::delete(id);

    }


    fun mint_massive_onslaught(ctx: &mut TxContext) : MassiveOnslaught {
        let id = object::new(ctx);

        MassiveOnslaught {
            id: id,
            name: utf8(b"massive onslaught"),
            image_url: utf8(b"ipfs://massive_onslaught_image_url"),
        }
    }


    
    public fun delete_massive_onslaught(massive_onslaught: MassiveOnslaught) {
        let MassiveOnslaught { id, name: _, image_url: _ } = massive_onslaught;
        object::delete(id);
    }







    // ----------------------------------------------
    // SPECIAL ACTIONS
    // ----------------------------------------------

    // BATTLE CRY **************************************
    struct BattleCry has key, store {
        id: UID,
        name: String, 
        image_url: String,
    }


    // when card is played it is lost, and the effect is applied to the player's character
    public fun use_battle_cry( battle_cry: BattleCry, ctx: &mut TxContext) {


        // All your characters gain +1 attack for the turn. (Cost: 3 CP)

        let BattleCry {
            id,
            name: _,
            image_url: _,
        
        } = battle_cry; 

        object::delete(id);

    }


    fun mint_battle_cry(ctx: &mut TxContext) : BattleCry {
        let id = object::new(ctx);

        BattleCry {
            id: id,
            name: utf8(b"massivebattle cry onslaught"),
            image_url: utf8(b"ipfs://battle_cry_image_url"),
        }
    }


    
    public fun delete_battle_cry(battle_cry: BattleCry) {
        let BattleCry { id, name: _, image_url: _ } = battle_cry;
        object::delete(id);
    }




    // DECISIVE STRIKE *********************************
    struct DecisiveStrike has key, store {
        id: UID,
        name: String, 
        image_url: String,
    }


    // when card is played it is lost, and the effect is applied to the player's character
    public fun use_decisive_strike( decisive_strike: DecisiveStrike, ctx: &mut TxContext) {


        // Deal 3 damage directly to an enemy character; this damage bypasses normal defense calculations. (Cost: 4 CP)

        let DecisiveStrike {
            id,
            name: _,
            image_url: _,
        
        } = decisive_strike; 

        object::delete(id);

    }


    fun mint_decisive_strike(ctx: &mut TxContext) : DecisiveStrike {
        let id = object::new(ctx);

        DecisiveStrike {
            id: id,
            name: utf8(b"decisive strike"),
            image_url: utf8(b"ipfs://decisive_strike_image_url"),
        }
    }


    
    public fun delete_decisive_strike(decisive_strike: DecisiveStrike) {
        let DecisiveStrike { id, name: _, image_url: _ } = decisive_strike;
        object::delete(id);
    }




    // SHIELD BASH *************************************
    struct ShieldBash has key, store {
        id: UID,
        name: String, 
        image_url: String,
    }


    // when card is played it is lost, and the effect is applied to the player's character
    public fun use_shield_bash( shield_bash: ShieldBash, ctx: &mut TxContext) {


        // If your character successfully defends against an attack, deal 2 damage to the attacker. (Cost: 2 CP)
        let ShieldBash {
            id,
            name: _,
            image_url: _,
        
        } = shield_bash; 

        object::delete(id);

    }


    fun mint_shield_bash(ctx: &mut TxContext) : ShieldBash {
        let id = object::new(ctx);

        ShieldBash {
            id: id,
            name: utf8(b"shield bash"),
            image_url: utf8(b"ipfs://shield_bash_image_url"),
        }
    }


    
    public fun delete_shield_bash(shield_bash: ShieldBash) {
        let ShieldBash { id, name: _, image_url: _ } = shield_bash;
        object::delete(id);
    }










    // ----------------------------------------------
    // STAT MODIFIERS
    // ----------------------------------------------
    // BOOST ATTACK **************************************
    struct BoostAttack has key, store {
        id: UID,
        name: String, 
        image_url: String,
    }


    // when card is played it is lost, and the effect is applied to the player's character
    public fun use_boost_attack( boost_attack: BoostAttack, ctx: &mut TxContext) {


        // Temporarily increases a character's attack by +2 for one turn. (Cost: 2 CP)
        let BoostAttack {
            id,
            name: _,
            image_url: _,
        
        } = boost_attack; 

        object::delete(id);

    }


    fun mint_boost_attack(ctx: &mut TxContext) : BoostAttack {
        let id = object::new(ctx);

        BoostAttack {
            id: id,
            name: utf8(b"boost attack"),
            image_url: utf8(b"ipfs://boost_attack_image_url"),
        }
    }


    
    public fun delete_boost_attack(boost_attack: BoostAttack) {
        let BoostAttack { id, name: _, image_url: _ } = boost_attack;
        object::delete(id);
    }




    // FORTIFY DEFENSE *********************************
    struct FortifyDefense has key, store {
        id: UID,
        name: String, 
        image_url: String,
    }


    // when card is played it is lost, and the effect is applied to the player's character
    public fun use_fortify_defense( fortify_defense: FortifyDefense, ctx: &mut TxContext) {


        // Increases a character's defense by +2 until your next turn. (Cost: 2 CP)
        let FortifyDefense {
            id,
            name: _,
            image_url: _,
        
        } = fortify_defense; 

        object::delete(id);

    }


    fun mint_fortify_defense(ctx: &mut TxContext) : FortifyDefense {
        let id = object::new(ctx);

        FortifyDefense {
            id: id,
            name: utf8(b"fortify defense"),
            image_url: utf8(b"ipfs://fortify_defense_image_url"),
        }
    }


    
    public fun delete_fortify_defense(fortify_defense: FortifyDefense) {
        let FortifyDefense { id, name: _, image_url: _ } = fortify_defense;
        object::delete(id);
    }




    // VITALITY SURGE ********************************
    struct VitalitySurge has key, store {
        id: UID,
        name: String, 
        image_url: String,
    }


    // when card is played it is lost, and the effect is applied to the player's character
    public fun use_vitality_surge( vitality_surge: VitalitySurge, ctx: &mut TxContext) {


        // Immediately restore 3 health to a character. (Cost: 3 CP)
        let VitalitySurge {
            id,
            name: _,
            image_url: _,
        
        } = vitality_surge; 

        object::delete(id);

    }


    fun mint_vitality_surge(ctx: &mut TxContext) : VitalitySurge {
        let id = object::new(ctx);

        VitalitySurge {
            id: id,
            name: utf8(b"vitality surge"),
            image_url: utf8(b"ipfs://vitality_surge_image_url"),
        }
    }


    
    public fun delete_vitality_surge(vitality_surge: VitalitySurge) {
        let VitalitySurge { id, name: _, image_url: _ } = vitality_surge;
        object::delete(id);
    }









    // ----------------------------------------------
    // TACTICAL MOVES
    // ----------------------------------------------

    // AMBUSH **************************************
    struct Ambush has key, store {
        id: UID,
        name: String, 
        image_url: String,
    }


    // when card is played it is lost, and the effect is applied to the player's character
    public fun use_ambush( ambush: Ambush, ctx: &mut TxContext) {


        // Play this card when an opponent declares an attack; your character gains +3 to defense for that combat. (Cost: 3 CP)

        let Ambush {
            id,
            name: _,
            image_url: _,
        
        } = ambush; 

        object::delete(id);

    }


    fun mint_ambush(ctx: &mut TxContext) : Ambush {
        let id = object::new(ctx);

        Ambush {
            id: id,
            name: utf8(b"ambush"),
            image_url: utf8(b"ipfs://ambush_image_url"),
        }
    }


    
    public fun delete_ambush(ambush: Ambush) {
        let Ambush { id, name: _, image_url: _ } = ambush;
        object::delete(id);
    }




    // QUICK RETREAT *********************************
    struct QuickRetreat has key, store {
        id: UID,
        name: String, 
        image_url: String,
    }


    // when card is played it is lost, and the effect is applied to the player's character
    public fun use_quick_retreat( quick_retreat: QuickRetreat, ctx: &mut TxContext) {


        // Move one of your characters to a reserve position, making it untargetable until the next turn. (Cost: 2 CP)
        let QuickRetreat {
            id,
            name: _,
            image_url: _,
        
        } = quick_retreat; 

        object::delete(id);

    }


    fun mint_quick_retreat(ctx: &mut TxContext) : QuickRetreat {
        let id = object::new(ctx);

        QuickRetreat {
            id: id,
            name: utf8(b"quick retreat"),
            image_url: utf8(b"ipfs://quick_retreat_image_url"),
        }
    }


    
    public fun delete_quick_retreat(quick_retreat: QuickRetreat) {
        let QuickRetreat { id, name: _, image_url: _ } = quick_retreat;
        object::delete(id);
    }




    // REINFORCEMENTS *********************************
    struct Reinforcements has key, store {
        id: UID,
        name: String, 
        image_url: String,
    }


    // when card is played it is lost, and the effect is applied to the player's character
    public fun use_reinforcements( reinforcements: Reinforcements, ctx: &mut TxContext) {


        // Draw two cards from your deck. (Cost: 2 CP)
        let Reinforcements {
            id,
            name: _,
            image_url: _,
        
        } = reinforcements; 

        object::delete(id);

    }


    fun mint_reinforcements(ctx: &mut TxContext) : Reinforcements {
        let id = object::new(ctx);

        Reinforcements {
            id: id,
            name: utf8(b"reinforcements"),
            image_url: utf8(b"ipfs://reinforcements_image_url"),
        }
    }


    
    public fun delete_reinforcements(reinforcements: Reinforcements) {
        let Reinforcements { id, name: _, image_url: _ } = reinforcements;
        object::delete(id);
    }







    // ----------------------------------------------
    // STRATEGIC EFFECTS
    // ----------------------------------------------

    // PEACE TREATY ***********************************
    struct PeaceTreaty has key, store {
        id: UID,
        name: String, 
        image_url: String,
    }


    // when card is played it is lost, and the effect is applied to the player's character
    public fun use_peace_treaty( peace_treaty: PeaceTreaty, ctx: &mut TxContext) {


        // Neither player can attack for the next turn. (Cost: 2 CP)
        let PeaceTreaty {
            id,
            name: _,
            image_url: _,
        
        } = peace_treaty; 

        object::delete(id);

    }


    fun mint_peace_treaty(ctx: &mut TxContext) : PeaceTreaty {
        let id = object::new(ctx);

        PeaceTreaty {
            id: id,
            name: utf8(b"peace treaty"),
            image_url: utf8(b"ipfs://peace_treaty_image_url"),
        }
    }


    
    public fun delete_peace_treaty(peace_treaty: PeaceTreaty) {
        let PeaceTreaty { id, name: _, image_url: _ } = peace_treaty;
        object::delete(id);
    }




    // SABOTAGE **************************************
    struct Sabotage has key, store {
        id: UID,
        name: String, 
        image_url: String,
    }


    // when card is played it is lost, and the effect is applied to the player's character
    public fun use_sabotage( sabotage: Sabotage, ctx: &mut TxContext) {


        // Target opponent generates 2 less CP on their next turn. (Cost: 3 CP)
        let Sabotage {
            id,
            name: _,
            image_url: _,
        
        } = sabotage; 

        object::delete(id);

    }


    fun mint_sabotage(ctx: &mut TxContext) : Sabotage {
        let id = object::new(ctx);

        Sabotage {
            id: id,
            name: utf8(b"sabotage"),
            image_url: utf8(b"ipfs://sabotage_image_url"),
        }
    }


    
    public fun delete_sabotage(sabotage: Sabotage) {
        let Sabotage { id, name: _, image_url: _ } = sabotage;
        object::delete(id);
    }




    // WAR DRUMS *************************************
    struct WarDrums has key, store {
        id: UID,
        name: String, 
        image_url: String,
    }


    // when card is played it is lost, and the effect is applied to the player's character
    public fun use_war_drums( war_drums: WarDrums, ctx: &mut TxContext) {


        // Increase the CP generation by 1 for the next two turns. (Cost: 4 CP)
        let WarDrums {
            id,
            name: _,
            image_url: _,
        
        } = war_drums; 

        object::delete(id);

    }


    fun mint_war_drums(ctx: &mut TxContext) : WarDrums {
        let id = object::new(ctx);

        WarDrums {
            id: id,
            name: utf8(b"war drums"),
            image_url: utf8(b"ipfs://war_drums_image_url"),
        }
    }


    
    public fun delete_war_drums(war_drums: WarDrums) {
        let WarDrums { id, name: _, image_url: _ } = war_drums;
        object::delete(id);
    }









    // ----------------------------------------------
    // UTILITY CARDS
    // ----------------------------------------------

    // ESPIONAGE **************************************
    struct Espionage has key, store {
        id: UID,
        name: String, 
        image_url: String,
    }


    // when card is played it is lost, and the effect is applied to the player's character
    public fun use_espionage( espionage: Espionage, ctx: &mut TxContext) {


        // Look at an opponent's hand, select one card they must discard. (Cost: 4 CP)
        let Espionage {
            id,
            name: _,
            image_url: _,
        
        } = espionage; 

        object::delete(id);

    }


    fun mint_espionage(ctx: &mut TxContext) : Espionage {
        let id = object::new(ctx);

        Espionage {
            id: id,
            name: utf8(b"espionage"),
            image_url: utf8(b"ipfs://espionage_image_url"),
        }
    }


    
    public fun delete_espionage(espionage: Espionage) {
        let Espionage { id, name: _, image_url: _ } = espionage;
        object::delete(id);
    }




    // REGROUP ***************************************
    struct Regroup has key, store {
        id: UID,
        name: String, 
        image_url: String,
    }


    // when card is played it is lost, and the effect is applied to the player's character
    public fun use_regroup( regroup: Regroup, ctx: &mut TxContext) {


        // Shuffle up to three cards from your discard pile back into your deck. (Cost: 3 CP)
        let Regroup {
            id,
            name: _,
            image_url: _,
        
        } = regroup; 

        object::delete(id);

    }


    fun mint_regroup(ctx: &mut TxContext) : Regroup {
        let id = object::new(ctx);

        Regroup {
            id: id,
            name: utf8(b"regroup"),
            image_url: utf8(b"ipfs://regroup_image_url"),
        }
    }


    
    public fun delete_regroup(regroup: Regroup) {
        let Regroup { id, name: _, image_url: _ } = regroup;
        object::delete(id);
    }




    // SCOUT *****************************************
    struct Scout has key, store {
        id: UID,
        name: String, 
        image_url: String,
    }


    // when card is played it is lost, and the effect is applied to the player's character
    public fun use_scout( scout: Scout, ctx: &mut TxContext) {


        // Shuffle up to three cards from your discard pile back into your deck. (Cost: 3 CP)
        let Scout {
            id,
            name: _,
            image_url: _,
        
        } = scout; 

        object::delete(id);

    }


    fun mint_scout(ctx: &mut TxContext) : Scout {
        let id = object::new(ctx);

        Scout {
            id: id,
            name: utf8(b"scout"),
            image_url: utf8(b"ipfs://scout_image_url"),
        }
    }


    
    public fun delete_scout(scout: Scout) {
        let Scout { id, name: _, image_url: _ } = scout;
        object::delete(id);
    }

    










    struct MORE_CARDS has drop {}


    fun init(otw: MORE_CARDS, ctx: &mut TxContext) {


        // divine shield
        let divine_shield_keys = vector[
            utf8(b"name"),
            utf8(b"link"),
            utf8(b"image_url"),
            utf8(b"description"),
            utf8(b"project_url"),
            utf8(b"creator"),
        ];

        let divine_shield_values = vector[
            utf8(b"{name}"),
            utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
            utf8(b"ipfs://{image_url}"),
            utf8(b"capy vs. gnome"),
            utf8(b"https://capy-vs-gnome.xyz"),
            utf8(b"unk"),
        ];


        // last stand
        let last_stand_keys = vector[
            utf8(b"name"),
            utf8(b"link"),
            utf8(b"image_url"),
            utf8(b"description"),
            utf8(b"project_url"),
            utf8(b"creator"),
        ];

        let last_stand_values = vector[
            utf8(b"{name}"),
            utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
            utf8(b"ipfs://{image_url}"),
            utf8(b"capy vs. gnome"),
            utf8(b"https://capy-vs-gnome.xyz"),
            utf8(b"unk"),
        ];
        // massive onslaught
        let massive_onslaught_keys = vector[
            utf8(b"name"),
            utf8(b"link"),
            utf8(b"image_url"),
            utf8(b"description"),
            utf8(b"project_url"),
            utf8(b"creator"),
        ];

        let massive_onslaught_values = vector[
            utf8(b"{name}"),
            utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
            utf8(b"ipfs://{image_url}"),
            utf8(b"capy vs. gnome"),
            utf8(b"https://capy-vs-gnome.xyz"),
            utf8(b"unk"),
        ];
        // battle cry
        let battle_cry_keys = vector[
            utf8(b"name"),
            utf8(b"link"),
            utf8(b"image_url"),
            utf8(b"description"),
            utf8(b"project_url"),
            utf8(b"creator"),
        ];

        let battle_cry_values = vector[
            utf8(b"{name}"),
            utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
            utf8(b"ipfs://{image_url}"),
            utf8(b"capy vs. gnome"),
            utf8(b"https://capy-vs-gnome.xyz"),
            utf8(b"unk"),
        ];
        // decisive strike
        let decisive_strike_keys = vector[
            utf8(b"name"),
            utf8(b"link"),
            utf8(b"image_url"),
            utf8(b"description"),
            utf8(b"project_url"),
            utf8(b"creator"),
        ];

        let decisive_strike_values = vector[
            utf8(b"{name}"),
            utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
            utf8(b"ipfs://{image_url}"),
            utf8(b"capy vs. gnome"),
            utf8(b"https://capy-vs-gnome.xyz"),
            utf8(b"unk"),
        ];
        // shield bash
        let shield_bash_keys = vector[
            utf8(b"name"),
            utf8(b"link"),
            utf8(b"image_url"),
            utf8(b"description"),
            utf8(b"project_url"),
            utf8(b"creator"),
        ];

        let shield_bash_values = vector[
            utf8(b"{name}"),
            utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
            utf8(b"ipfs://{image_url}"),
            utf8(b"capy vs. gnome"),
            utf8(b"https://capy-vs-gnome.xyz"),
            utf8(b"unk"),
        ];
        // boost attack
        let boost_attack_keys = vector[
            utf8(b"name"),
            utf8(b"link"),
            utf8(b"image_url"),
            utf8(b"description"),
            utf8(b"project_url"),
            utf8(b"creator"),
        ];

        let boost_attack_values = vector[
            utf8(b"{name}"),
            utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
            utf8(b"ipfs://{image_url}"),
            utf8(b"capy vs. gnome"),
            utf8(b"https://capy-vs-gnome.xyz"),
            utf8(b"unk"),
        ];
        // fortify defense
        let fortify_defense_keys = vector[
            utf8(b"name"),
            utf8(b"link"),
            utf8(b"image_url"),
            utf8(b"description"),
            utf8(b"project_url"),
            utf8(b"creator"),
        ];

        let fortify_defense_values = vector[
            utf8(b"{name}"),
            utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
            utf8(b"ipfs://{image_url}"),
            utf8(b"capy vs. gnome"),
            utf8(b"https://capy-vs-gnome.xyz"),
            utf8(b"unk"),
        ];
        // vitality surge
        let vitality_surge_keys = vector[
            utf8(b"name"),
            utf8(b"link"),
            utf8(b"image_url"),
            utf8(b"description"),
            utf8(b"project_url"),
            utf8(b"creator"),
        ];

        let vitality_surge_values = vector[
            utf8(b"{name}"),
            utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
            utf8(b"ipfs://{image_url}"),
            utf8(b"capy vs. gnome"),
            utf8(b"https://capy-vs-gnome.xyz"),
            utf8(b"unk"),
        ];
        // ambush
        let ambush_keys = vector[
            utf8(b"name"),
            utf8(b"link"),
            utf8(b"image_url"),
            utf8(b"description"),
            utf8(b"project_url"),
            utf8(b"creator"),
        ];

        let ambush_values = vector[
            utf8(b"{name}"),
            utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
            utf8(b"ipfs://{image_url}"),
            utf8(b"capy vs. gnome"),
            utf8(b"https://capy-vs-gnome.xyz"),
            utf8(b"unk"),
        ];
        // quick retreat
        let quick_retreat_keys = vector[
            utf8(b"name"),
            utf8(b"link"),
            utf8(b"image_url"),
            utf8(b"description"),
            utf8(b"project_url"),
            utf8(b"creator"),
        ];

        let quick_retreat_values = vector[
            utf8(b"{name}"),
            utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
            utf8(b"ipfs://{image_url}"),
            utf8(b"capy vs. gnome"),
            utf8(b"https://capy-vs-gnome.xyz"),
            utf8(b"unk"),
        ];
        // reinforcements
        let reinforcements_keys = vector[
            utf8(b"name"),
            utf8(b"link"),
            utf8(b"image_url"),
            utf8(b"description"),
            utf8(b"project_url"),
            utf8(b"creator"),
        ];

        let reinforcements_values = vector[
            utf8(b"{name}"),
            utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
            utf8(b"ipfs://{image_url}"),
            utf8(b"capy vs. gnome"),
            utf8(b"https://capy-vs-gnome.xyz"),
            utf8(b"unk"),
        ];
        // peace treaty
        let peace_treaty_keys = vector[
            utf8(b"name"),
            utf8(b"link"),
            utf8(b"image_url"),
            utf8(b"description"),
            utf8(b"project_url"),
            utf8(b"creator"),
        ];

        let peace_treaty_values = vector[
            utf8(b"{name}"),
            utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
            utf8(b"ipfs://{image_url}"),
            utf8(b"capy vs. gnome"),
            utf8(b"https://capy-vs-gnome.xyz"),
            utf8(b"unk"),
        ];
        // sabotage
        let sabotage_keys = vector[
            utf8(b"name"),
            utf8(b"link"),
            utf8(b"image_url"),
            utf8(b"description"),
            utf8(b"project_url"),
            utf8(b"creator"),
        ];

        let sabotage_values = vector[
            utf8(b"{name}"),
            utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
            utf8(b"ipfs://{image_url}"),
            utf8(b"capy vs. gnome"),
            utf8(b"https://capy-vs-gnome.xyz"),
            utf8(b"unk"),
        ];
        // war drums
        let war_drums_keys = vector[
            utf8(b"name"),
            utf8(b"link"),
            utf8(b"image_url"),
            utf8(b"description"),
            utf8(b"project_url"),
            utf8(b"creator"),
        ];

        let war_drums_values = vector[
            utf8(b"{name}"),
            utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
            utf8(b"ipfs://{image_url}"),
            utf8(b"capy vs. gnome"),
            utf8(b"https://capy-vs-gnome.xyz"),
            utf8(b"unk"),
        ];
        // espionage
        let espionage_keys = vector[
            utf8(b"name"),
            utf8(b"link"),
            utf8(b"image_url"),
            utf8(b"description"),
            utf8(b"project_url"),
            utf8(b"creator"),
        ];

        let espionage_values = vector[
            utf8(b"{name}"),
            utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
            utf8(b"ipfs://{image_url}"),
            utf8(b"capy vs. gnome"),
            utf8(b"https://capy-vs-gnome.xyz"),
            utf8(b"unk"),
        ];
        // regroup
        let regroup_keys = vector[
            utf8(b"name"),
            utf8(b"link"),
            utf8(b"image_url"),
            utf8(b"description"),
            utf8(b"project_url"),
            utf8(b"creator"),
        ];

        let regroup_values = vector[
            utf8(b"{name}"),
            utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
            utf8(b"ipfs://{image_url}"),
            utf8(b"capy vs. gnome"),
            utf8(b"https://capy-vs-gnome.xyz"),
            utf8(b"unk"),
        ];
        // scout
        let scout_keys = vector[
            utf8(b"name"),
            utf8(b"link"),
            utf8(b"image_url"),
            utf8(b"description"),
            utf8(b"project_url"),
            utf8(b"creator"),
        ];

        let scout_values = vector[
            utf8(b"{name}"),
            utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
            utf8(b"ipfs://{image_url}"),
            utf8(b"capy vs. gnome"),
            utf8(b"https://capy-vs-gnome.xyz"),
            utf8(b"unk"),
        ];

        let publisher = package::claim(otw, ctx);


        // divine shield
        let display_divine_shield = display::new_with_fields<DivineShield>(
            &publisher, divine_shield_keys, divine_shield_values, ctx
        );

        display::update_version(&mut display_divine_shield);


        // last stand
        let display_last_stand = display::new_with_fields<LastStand>(
            &publisher, last_stand_keys, last_stand_values, ctx
        );

        display::update_version(&mut display_last_stand);

        // massive onslaught
        let display_massive_onslaught = display::new_with_fields<MassiveOnslaught>(
            &publisher, massive_onslaught_keys, massive_onslaught_values, ctx
        );

        display::update_version(&mut display_massive_onslaught);
        
        // battle cry
        let display_battle_cry = display::new_with_fields<BattleCry>(
            &publisher, battle_cry_keys, battle_cry_values, ctx
        );

        display::update_version(&mut display_battle_cry);

        // decisive strike
        let display_decisive_strike = display::new_with_fields<DecisiveStrike>(
            &publisher, decisive_strike_keys, decisive_strike_values, ctx
        );

        display::update_version(&mut display_decisive_strike);

        // shield bash
        let display_shield_bash = display::new_with_fields<ShieldBash>(
            &publisher, shield_bash_keys, shield_bash_values, ctx
        );

        display::update_version(&mut display_shield_bash);

        // boost attack
        let display_boost_attack = display::new_with_fields<BoostAttack>(
            &publisher, boost_attack_keys, boost_attack_values, ctx
        );

        display::update_version(&mut display_boost_attack);

        // fortify defense
        let display_fortify_defense = display::new_with_fields<FortifyDefense>(
            &publisher, fortify_defense_keys, fortify_defense_values, ctx
        );

        display::update_version(&mut display_fortify_defense);

        // vitality surge
        let display_vitality_surge = display::new_with_fields<VitalitySurge>(
            &publisher, vitality_surge_keys, vitality_surge_values, ctx
        );

        display::update_version(&mut display_vitality_surge);

        // ambush
        let display_ambush= display::new_with_fields<Ambush>(
            &publisher, ambush_keys, ambush_values, ctx
        );

        display::update_version(&mut display_ambush);

        // quick retreat
        let display_quick_retreat= display::new_with_fields<QuickRetreat>(
            &publisher, quick_retreat_keys, quick_retreat_values, ctx
        );

        display::update_version(&mut display_quick_retreat);

        // reinforcements
        let display_reinforcements = display::new_with_fields<Reinforcements>(
            &publisher, reinforcements_keys, reinforcements_values, ctx
        );

        display::update_version(&mut display_reinforcements);

        // peace treaty
        let display_peace_treaty = display::new_with_fields<PeaceTreaty>(
            &publisher, peace_treaty_keys, peace_treaty_values, ctx
        );

        display::update_version(&mut display_peace_treaty);

        // sabotage
        let display_sabotage = display::new_with_fields<Sabotage>(
            &publisher, sabotage_keys, sabotage_values, ctx
        );

        display::update_version(&mut display_sabotage);
        
        // war drums
        let display_war_drums = display::new_with_fields<WarDrums>(
            &publisher, war_drums_keys, war_drums_values, ctx
        );

        display::update_version(&mut display_war_drums);

        // espionage
        let display_espionage = display::new_with_fields<Espionage>(
            &publisher, espionage_keys, espionage_values, ctx
        );

        display::update_version(&mut display_espionage);

        // regroup
        let display_regroup = display::new_with_fields<Regroup>(
            &publisher, regroup_keys, regroup_values, ctx
        );

        display::update_version(&mut display_regroup);

        // scout
        let display_scout= display::new_with_fields<Scout>(
            &publisher, scout_keys, scout_values, ctx
        );

        display::update_version(&mut display_scout);



        // transfer publisher
        transfer::public_transfer(publisher, tx_context::sender(ctx));
        // transfer character displays
        
        // divine shield
        transfer::public_transfer(display_divine_shield, tx_context::sender(ctx));
        
        // last stand
        transfer::public_transfer(display_last_stand, tx_context::sender(ctx));
        
        // massive onslaught
        transfer::public_transfer(display_massive_onslaught, tx_context::sender(ctx));

        // battle cry
        transfer::public_transfer(display_battle_cry, tx_context::sender(ctx));

        // decisive strike
        transfer::public_transfer(display_decisive_strike, tx_context::sender(ctx));

        // shield bash
        transfer::public_transfer(display_shield_bash, tx_context::sender(ctx));

        // boost attack
        transfer::public_transfer(display_boost_attack, tx_context::sender(ctx));

        // fortify defense
        transfer::public_transfer(display_fortify_defense, tx_context::sender(ctx));

        // vitality surge
        transfer::public_transfer(display_vitality_surge, tx_context::sender(ctx));

        // ambush
        transfer::public_transfer(display_ambush, tx_context::sender(ctx));

        // quick retreat
        transfer::public_transfer(display_quick_retreat, tx_context::sender(ctx));

        // reinforcements
        transfer::public_transfer(display_reinforcements, tx_context::sender(ctx));

        // peace treaty
        transfer::public_transfer(display_peace_treaty, tx_context::sender(ctx));

        // sabotage
        transfer::public_transfer(display_sabotage, tx_context::sender(ctx));

        // war drums
        transfer::public_transfer(display_war_drums, tx_context::sender(ctx));

        // espionage
        transfer::public_transfer(display_espionage, tx_context::sender(ctx));

        // regroup
        transfer::public_transfer(display_regroup, tx_context::sender(ctx));

        // scout
        transfer::public_transfer(display_scout, tx_context::sender(ctx));


    }




    






    #[test_only]
    public fun init_for_testing(otw: MORE_CARDS, ctx: &mut TxContext) {
        init(otw, ctx);
    }





}
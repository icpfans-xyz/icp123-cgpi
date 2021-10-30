import Result "mo:base/Result";

module {


    // Metadata of a Project.
    public type Metadata = {
        projectId            : Text; // Name of the Project.
        projectName          : Text; // Name of the Project
        // TODO: add more fields (e.g. genre, ...)
    };

    // Represents the interface of a Register canister what wants to interact with 
    // the ICP123CGP canister.
    public type ToUpInterface = actor {
        // Implement canister recharge interface
        topUp              : shared() -> async Nat;

        // Check balances
        canisterBalance    : shared() -> async Nat;

        // Function so the register (actor) can register itself.
        icp123RegisterSelf :   shared (RegisterCallback) -> async ();
    };

    // Callback on which new games should register.
    public type RegisterCallback = shared (
        // Metadata of the game itself.
        metadata : Metadata
    ) -> async ();


    // Represents the (minimal) interface of the Metascore canister.
    public type ICP123CGPInterface = actor {
        // Methods that needs to be called to register 
        registerCanister : (Metadata) -> async Result.Result<(), Text>;
    };
};

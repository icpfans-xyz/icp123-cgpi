import Result "mo:base/Result";
import Type "../src/Type";

module {

    type CARData = Type.CARData;
    type Metadata = Type.Metadata;

    // CHORE: make sure this is updated! Ensures some compiler checks. ~ quint
    public type FullInterface = actor {

        icp123CARSudograph :   query (Text) -> async Result.Result<(), Text>;

        // Methods that needs to be called to register 
        // Can be called by any principal account. CARData will register
        // itself by calling the callback given in 'icp123RegisterSelf'.
        icp123CAR     : shared (CARData) -> async Result.Result<(), Text>;

        // Endpoint to send CARData updates to.
        crdDataUpdate : shared ([CARData]) -> async ();
    };

};

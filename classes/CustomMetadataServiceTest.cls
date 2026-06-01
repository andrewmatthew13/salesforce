@IsTest
private class CustomMetadataServiceTest {

    /**
    * This is only a coverage test, since it's not possible to deploy MD in unit tests and it's not possible to know
    * what kind of custom metadata may be on the org.
    */
    @IsTest
    static void coverage() {
        try {
            CustomMetadataService.deploy(new List<SObject>{
                new RecordType(DeveloperName = 'Test', Name='Test')
            });
        } catch (Exception ex) {
        }
    }
}
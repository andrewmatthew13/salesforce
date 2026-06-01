public with sharing class CustomMetadataService {

    /**
    * Deploys list of Custom Metadata records to org.
    * This method can be copy-pasted into Anonymous Apex script and used without deploying this class
    *
    * Example:
    * <pre>
    *     CustomMetadataDeployer.deploy(new List<SomeMapping__mdt>{
    *           new SomeMapping__mdt(DeveloperName='X', Label='X', Field__c='X),
    *           new SomeMapping__mdt(DeveloperName='Y', Label='Y', Field__c='Y),
    *     });
    * </pre>
    *
    * @param customMetadataRecords List of Custom Metadata records. DeveloperName and Label fields are required.
    * @return ID of deployment request.
    */
    public static Id deploy(List<SObject> customMetadataRecords) {
        Metadata.DeployContainer mdContainer = new Metadata.DeployContainer();

        for (SObject record : customMetadataRecords) {
            Map<String, Object> populatedFields = record.getPopulatedFieldsAsMap().clone();

            Metadata.CustomMetadata customMetadata = new Metadata.CustomMetadata();
            customMetadata.fullName = ('' + record.getSObjectType()).remove('__mdt') + '.' + populatedFields.get('DeveloperName');
            customMetadata.label = (String) populatedFields.get('Label');

            populatedFields.remove('Id');
            populatedFields.remove('Label');
            populatedFields.remove('DeveloperName');

            for (String field : populatedFields.keySet()) {
                Metadata.CustomMetadataValue customField = new Metadata.CustomMetadataValue();
                customField.field = field;
                customField.value = populatedFields.get(field);

                customMetadata.values.add(customField);
            }

            mdContainer.addMetadata(customMetadata);
        }

        return Metadata.Operations.enqueueDeployment(mdContainer, null);
    }
}
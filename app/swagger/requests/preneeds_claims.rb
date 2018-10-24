# frozen_string_literal: true

module Swagger
  module Requests
    class PreneedsClaims
      include Swagger::Blocks

      swagger_path '/v0/preneeds/burial_forms' do
        operation :post do
          extend Swagger::Responses::ValidationError
          extend Swagger::Responses::SavedForm

          key :description, 'Submit a pre-need burial eligibility claim'
          key :operationId, 'addPreneedsClaim'
          key :tags, %w[benefits_forms]

          parameter :optional_authorization

          parameter do
            key :name, :application
            key :in, :body
            key :description, 'Pre-need burial eligibility form data'
            key :required, true

            # TODO: add `required` designations

            schema do
              property :applicationStatus, type: :string, example: 'example needed' # TODO: not in schema.  remove?
              property :hasCurrentlyBuried, type: :string, example: '1', enum: %w[1 2 3]
              property :sendingCode, type: :string, example: 'abc' # TODO: not in schema.  remove?
              property :preneedAttachments, type: :array, description: 'data about uploaded attachments' do
                items do
                  property :confirmationCode, type: :string, description: 'uuid',
                                              example: '9b3ae0e1-fd58-4074-bf81-d58fb18fa86'
                  property :attachmentId, type: :string, example: '1'
                  property :name, type: :string, example: 'my_file_name.pdf'
                end
              end
              property :applicant, type: :object do
                property :applicantEmail, type: :string, example: 'jon.doe@example.com'
                property :applicantPhoneNumber, type: :string, example: '5551235454'
                property :applicantRelationshipToClaimant, type: :string, example: 'Authorized Agent/Rep'
                property :completingReason, type: :string, example: 'a reason'
                property :mailingAddress, type: :object do
                  property :street, type: :string, example: '140 Rock Creek Church Rd NW'
                  property :street2, type: :string, example: ''
                  property :city, type: :string, example: 'Washington'
                  property :country, type: :string, example: 'USA'
                  property :state, type: :string, example: 'DC'
                  property :postalCode, type: :string, example: '20011'
                end
                property :name, type: :object do
                  property :first, type: :string, example: 'Jon'
                  property :middle, type: :string, example: 'Bob'
                  property :last, type: :string, example: 'Doe'
                  property :maiden, type: :string, example: 'Smith'
                  property :suffix, type: :string, example: 'Jr.' 
                end
              end
              property :claimant, type: :object do
                property :address, type: :object do
                  property :street, type: :string, example: '140 Rock Creek Church Rd NW'
                  property :street2, type: :string, example: ''
                  property :city, type: :string, example: 'Washington'
                  property :country, type: :string, example: 'USA'
                  property :state, type: :string, example: 'DC'
                  property :postalCode, type: :string, example: '20011'
                end
                property :dateOfBirth, type: :string, example: '1960-12-30'
                property :desiredCemetery, type: :string, example: '234'
                property :email, type: :string, example: 'jon.doe@example.com'
                property :name, type: :object do
                  property :first, type: :string, example: 'Jon'
                  property :middle, type: :string, example: 'Bob'
                  property :last, type: :string, example: 'Doe'
                  property :maiden, type: :string, example: 'Smith'
                  property :suffix, type: :string, example: 'Jr.' 
                end
                property :phoneNumber, type: :string, example: '5551235454'
                property :relationshipToVet, type: :string, example: '2'
                property :ssn, type: :string, example: '234234234'                
              end
              property :veteran, type: :object do
                property :address, type: :object do
                  property :street, type: :string, example: '140 Rock Creek Church Rd NW'
                  property :street2, type: :string, example: ''
                  property :city, type: :string, example: 'Washington'
                  property :country, type: :string, example: 'USA'
                  property :state, type: :string, example: 'DC'
                  property :postalCode, type: :string, example: '20011'
                end
                property :currentName, type: :object do
                  property :first, type: :string, example: 'Jon'
                  property :middle, type: :string, example: 'Bob'
                  property :last, type: :string, example: 'Doe'
                  property :maiden, type: :string, example: 'Smith'
                  property :suffix, type: :string, example: 'Jr.' 
                end
                property :dateOfBirth, type: :string, example: '1960-12-30'
                property :dateOfDeath, type: :string, example: '1990-12-30'
                property :gender, type: :string, example: 'Female'
                property :isDeceased, type: :string, example: 'yes'                
                property :maritalStatus, type: :string, example: 'Single'
                property :militaryServiceNumber, type: :string, example: '234234234'
                property :militaryStatus, type: :string, example: 'D'
                property :placeOfBirth, type: :string, example: '140 Rock Creek Church Rd NW'
                property :serviceName, type: :object do
                  property :first, type: :string, example: 'Jon'
                  property :middle, type: :string, example: 'Bob'
                  property :last, type: :string, example: 'Doe'
                  property :suffix, type: :string, example: 'Jr.' 
                end
                property :serviceRecords, type: :array, description: 'data about tours of duty' do
                  items do
                    property :dateRange, type: :object, do
                      property :from, type: :string, example: '1960-12-30'
                      property :to, type: :string, example: '1970-12-30'
                    end
                    property :serviceBranch, type: :string, example: 'AL'
                    property :dischargeType, type: :string, example: '2'
                    property :highestRank, type: :string, example: 'General'
                    property :nationalGuardState, type: :string, example: 'PR'
                  end
                end
                property :ssn, type: :string, example: '234234234' 
                property :vaClaimNumber, type: :string, example: '234234234'     
              end                            
            end
          end
        end
      end
    end
  end
end

# TODO
# permitted params from burial_forms_controller
# :application_status, :has_currently_buried, :sending_code,
#           preneed_attachments: ::Preneeds::PreneedAttachmentHash.permitted_params,
#           applicant: ::Preneeds::Applicant.permitted_params,
#           claimant: ::Preneeds::Claimant.permitted_params,
#           currently_buried_persons: ::Preneeds::CurrentlyBuriedPerson.permitted_params,
#           veteran: ::Preneeds::Veteran.permitted_params

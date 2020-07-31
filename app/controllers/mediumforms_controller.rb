class MediumformsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_mediumform, only: [:show, :edit, :update, :destroy]

  def index
    @mediumform = Mediumform.all
  end

  def new
    @mediumform = current_user.build_mediumform
    @mediumpreference = MediumformPreference.selfclassify_preferences
  end

  def show
    @mediumform = Mediumform.find(params[:id])
  end

  def edit
    @mediumform = current_user.mediumform

    @user = User.find(@mediumform.user_id)
    #   n = @mediumform.known_deads.count
    #   (5-n).times {@mediumform.known_deads.build}
  end

  # POST /mediumforms
  # POST /mediumforms.json
  def create
    @mediumform = Mediumform.new(mediumform_params)
    @mediumform.user_id = current_user.id

    respond_to do |format|
      if @mediumform.save
        if @mediumform.signature_checkbox
          @user = current_user
          @user.medium_registration = false
          @user.save
        end
        format.html { redirect_to root_path, notice: 'Mediumform was successfully created.' }
        #format.html { redirect_to @mediumform, notice: 'Mediumform was successfully created.' }
        #format.json { render :show, status: :created, location: @mediumform }
      else
        format.html { render :new }
        format.json { render json: @mediumform.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mediumforms/1
  # PATCH/PUT /mediumforms/1.json
  def update

    respond_to do |format|
      #if @mediumform.update(mediumform_params)
      if @mediumform.update_attributes params[:mediumform]
        if @mediumform.signature_checkbox
          @user = current_user
          @user.medium_registration = false
          @user.save
        end
        if @mediumform.signature_checkbox
          format.html { redirect_to current_user, notice: 'Mediumform was successfully completed.' }
        else
          format.html { redirect_to current_user, notice: 'Mediumform was successfully updated.' }
        end
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /user2s/1
  # DELETE /user2s/1.json
  def destroy
    @mediumform = Mediumform.find(params[:id])
    @Mediumform.destroy
    respond_to do |format|
      format.html { redirect_to @mediumform, notice: 'Mediumform was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_mediumform
    @mediumform = Mediumform.find(params[:id])

  end

  def mediumform_params
    params.require(:mediumform).permit(:user_id, \
                                       :personalprofessional,
                                       #:professional_name, :professional_address_line1, :professional_address_line2, \
                                       #:professional_phone_number, :professional_email, \
                                       :other_businesses, :health_healing, \
                                       :MEPC_Removed, :MEPC_Failed, :admin_notes,\
                                       :website, :blog, :facebook, :pinterest, :instagram, :twitter, :youtube, :other, \
                                       :sitter1, :sitter2, :sitter3, :sitter4, :sitter5, \
                                       :SitterA, :SitterB, :SitterC, :SitterD, :SitterE, \
                                       :medium_status, :test_date, :application_date, \
                                       :alt_first_name, :alt_middle_name, :alt_last_name, \
                                       :alt_mobile_phone, :alt_work_phone, :alt_home_phone, \
                                       :alt_work_email, :alt_home_email, \
                                       :alt_address_line1, :alt_address_line2, :alt_city, :alt_state, :alt_zipcode, :alt_country, \
                                       :other_primary_owner, :other_related, :other_not_related, \
                                       :became_aware, :immediate_family, :life_event, :specific_goal, :medium_priority, \
                                       :different_info, :hear_about_fff, :medium_history, :mediumship_training, \
                                       :kind_of_readings, :self_classify, :other_classify, \
                                       :ethics1, :ethics2, :ethics3, :ethics4, \
                                       :other_certification, \
                                       :signature_checkbox, :signature,  :mediumform_preference_ids =>[])
  end
end

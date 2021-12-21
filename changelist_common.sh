#!/bin/bash
set -x
##########################################################
### Internal function used to properly kill the job
##########################################################
die(){
	printf "*****ERROR***** $1\n"
	exit 1
}

MW_PATH=$WORKSPACE/$PROJECT/$VARIANT/CHANGE_LIST
NEW_MW_TAG=$1
OLD_MW_TAG=$2


repo_choice()
{
if [[ "$ANDROID_VERSION" = "P" && "$PROJECT" = "PN8xT" && "$VARIANT" = "RoW" ]]
then
	gitbranch="br_android_p_mw_row_dev"
	
	repoList=()
	repoList+=("nxp_nci_hal_nfc")
	repoList+=("nxp_nci_hal_libnfc-nci")
	repoList+=("nxp_nci_hal_base")  
	repoList+=("nxp_nci_hal_internal")
	repoList+=("p61-jcop-kit")
	repoList+=("p61-spi-service")
	repoList+=("nfcandroid_secureelement")
	repoList+=("nfcandroid_se_hidlimpl")
	repoList+=("nfcandroid_platform")
	repoList+=("nfcandroid_nfc_hidlimpl")
	repoList+=("nxp_ese_clients")
	
elif [[ "$ANDROID_VERSION" = "Q" && "$PROJECT" = "SN220" ]]
then
        gitbranch="br_ar_10_vulcan_base_dev"

        repoList=()
        repoList+=("nxp_nci_hal_nfc")
        repoList+=("nxp_nci_hal_libnfc-nci")
        repoList+=("nfcandroid_nfc_hidlimpl")
        repoList+=("nfcandroid_platform")

        repoListMaster=()
        repoListMaster+=("nxp_ese_clients")


elif [[ "$ANDROID_VERSION" = "Q" && "$PROJECT" = "PN8xT" && "$VARIANT" = "RoW" ]]
then
        gitbranch="br_ar_q_pn8xt_row_dev"

        repoList=()
        repoList+=("nxp_nci_hal_nfc")
        repoList+=("nxp_nci_hal_libnfc-nci")
        repoList+=("nxp_nci_hal_base")
        repoList+=("nfcandroid_secureelement")
        repoList+=("nfcandroid_se_hidlimpl")
        repoList+=("nfcandroid_platform")
        repoList+=("nfcandroid_nfc_hidlimpl")
        repoList+=("nfcandroid_wiredse")
	repoList+=("nxp_ese_clients")
	repoList+=("nfcandroid_frameworks")

 
elif [[ "$ANDROID_VERSION" = "P" && "$PROJECT" = "PN80T" && "$VARIANT" = "SSG" ]]
then
	gitbranch="br_android_ncihalx_p_treble_ssg"
	
	repoList=()
	repoList+=("nxp_nci_hal_nfc")
	repoList+=("nxp_nci_hal_libnfc-nci")
	repoList+=("nxp_nci_hal_base")  
	repoList+=("nfcandroid_secureelement")
	repoList+=("nfcandroid_se_hidlimpl")
	repoList+=("nfcandroid_platform")
	repoList+=("nfcandroid_nfc_hidlimpl")
	

elif [[ "$ANDROID_VERSION" = "Q" && "$PROJECT" = "PN80T" && "$VARIANT" = "SSG" ]]
then
	gitbranch="br_ar_q_pn80t_ssg_dev"
	
	repoList=()
	repoList+=("nxp_nci_hal_nfc")
	repoList+=("nxp_nci_hal_libnfc-nci")
	repoList+=("nxp_nci_hal_base")  
	repoList+=("nfcandroid_secureelement")
	repoList+=("nfcandroid_se_hidlimpl")
	repoList+=("nfcandroid_platform")
	repoList+=("nfcandroid_nfc_hidlimpl")
	
elif [[ "$ANDROID_VERSION" = "R" && "$PROJECT" = "PN80T" && "$VARIANT" = "SSG" ]]
then
        gitbranch="br_ar_11_pn80t_ssg_dev"

        repoList=()
        repoList+=("nxp_nci_hal_nfc")
        repoList+=("nxp_nci_hal_libnfc-nci")
        repoList+=("nxp_nci_hal_base")
        repoList+=("nfcandroid_secureelement")
        repoList+=("nfcandroid_se_hidlimpl")
        repoList+=("nfcandroid_platform")
        repoList+=("nfcandroid_nfc_hidlimpl")
        repoList+=("nfcandroid_hidlintf_se")

	
elif [[ "$ANDROID_VERSION" = "Q" && "$PROJECT" = "SN1xx" ]]
then
	gitbranch="br_ar_q_SN1xx_base_dev"
	
	repoList=()
	repoList+=("nxp_nci_hal_nfc")
	repoList+=("nxp_nci_hal_libnfc-nci")
	repoList+=("nxp_nci_hal_base")
	repoList+=("nfcandroid_frameworks")
	repoList+=("nfcandroid_nfc_hidlimpl")
	repoList+=("nfcandroid_secureelement")
	repoList+=("nfcandroid_se_hidlimpl")
	repoList+=("nfcandroid_platform")
	repoList+=("nfcandroid_wiredse")
	repoList+=("nfcandroid_hidlintf_se")

	if [[ "$CID" = "SSG" ]]
	then
		repoList+=("nfcandroid_nxp_libs")
	fi
	
	repoListMaster=()
	repoListMaster+=("nxp_ese_clients")

elif [[ "$ANDROID_VERSION" = "Q" && "$PROJECT" = "SN110" && "$CID" = "CUST" ]]
then
        gitbranch="br_ar_10_SN1xx_cust_dev"

        repoList=()
        repoList+=("nxp_nci_hal_nfc")
        repoList+=("nxp_nci_hal_libnfc-nci")
        repoList+=("nxp_nci_hal_base")
        repoList+=("nfcandroid_frameworks")
        repoList+=("nfcandroid_nfc_hidlimpl")
        repoList+=("nfcandroid_secureelement")
        repoList+=("nfcandroid_se_hidlimpl")
        repoList+=("nfcandroid_platform")
        repoList+=("nfcandroid_wiredse")
        repoList+=("nfcandroid_nxp_libs")
        repoList+=("nxp_ese_clients")



	
elif [[ "$ANDROID_VERSION" = "Q" && "$PROJECT" = "SN110" && "$CID" = "CR12"  ]]
then

        gitbranch="br_ar_q_SN1xx_cr12_dev"

        repoList=()
        repoList+=("nxp_nci_hal_nfc")
        repoList+=("nxp_nci_hal_libnfc-nci")
        repoList+=("nxp_nci_hal_base")
        repoList+=("nfcandroid_frameworks")
        repoList+=("nfcandroid_nfc_hidlimpl")
        repoList+=("nfcandroid_secureelement")
        repoList+=("nfcandroid_se_hidlimpl")
        repoList+=("nfcandroid_platform")
        repoList+=("nxp_ese_clients")
        repoList+=("nfcandroid_wiredse")
		
elif [[ "$ANDROID_VERSION" = "P" && "$PROJECT" = "SN1xx" ]]
then

	gitbranch="br_android_ncihalx_o_SN100_base"
	
	repoList=()
	repoList+=("nxp_nci_hal_nfc")
	repoList+=("nxp_nci_hal_libnfc-nci")
	repoList+=("nxp_nci_hal_base")
	repoList+=("nfcandroid_frameworks")
	repoList+=("nfcandroid_nfc_hidlimpl")
	repoList+=("nfcandroid_secureelement")
	repoList+=("nfcandroid_se_hidlimpl")
	repoList+=("nfcandroid_platform")
	
	if [[ "$CID" = "SSG" ]]
	then
		repoList+=("nfcandroid_nxp_libs")
	fi
	
	
	repoListMaster=()
	repoListMaster+=("nxp_ese_clients")
	repoListMaster+=("nfcandroid_wiredse")
	
	
elif [[ "$ANDROID_VERSION" = "P" && "$PROJECT" = "SN100" && "$CID" = "XIAOMI" ]]
then	
	gitbranch="br_ncihalx_ar_p_SN100x_row_dev"
	
	repoList=()
	repoList+=("nxp_nci_hal_nfc")
	repoList+=("nxp_nci_hal_libnfc-nci")
	repoList+=("nxp_nci_hal_base")  
	repoList+=("nfcandroid_secureelement")
	repoList+=("nfcandroid_se_hidlimpl")
	repoList+=("nfcandroid_platform")
	repoList+=("nfcandroid_nfc_hidlimpl")
	repoList+=("nfcandroid_frameworks")
	repoList+=("nfcandroid_wiredse")
	repoList+=("nxp_ese_clients")

	
elif [[ "$ANDROID_VERSION" = "P" && "$PROJECT" = "PN81B" && "$VARIANT" = "RoW" ]]
then

	gitbranch="br_android_nci2_0_aosp_fn_dev"
	
	repoList=()
	repoList+=("nxp_nci_hal_nfc")
	repoList+=("nxp_nci_hal_libnfc-nci")
	repoList+=("nxp_nci_hal_base")  
	repoList+=("nxp_nci_hal_internal")  
	repoList+=("p61-spi-service")  
	repoList+=("nfcandroid_secureelement")
	repoList+=("nfcandroid_se_hidlimpl")
	repoList+=("nfcandroid_platform")
	repoList+=("nfcandroid_nfc_hidlimpl")

elif [[ "$ANDROID_VERSION" = "R" && "$PROJECT" = "SN1xx" && "$CID" = "RoW" ]]
then

        gitbranch="br_ar_11_SN1xx_base_dev"

        repoList=()
        repoList+=("nxp_nci_hal_nfc")
        repoList+=("nxp_nci_hal_libnfc-nci")
        repoList+=("nxp_nci_hal_base")
        repoList+=("nxp_ese_clients")
        repoList+=("nfcandroid_wiredse")
        repoList+=("nfcandroid_nxp_libs")
        repoList+=("nfcandroid_frameworks")
        repoList+=("nfcandroid_hidlintf_se")
        repoList+=("nfcandroid_secureelement")
        repoList+=("nfcandroid_se_hidlimpl")
        repoList+=("nfcandroid_platform")
        repoList+=("nfcandroid_nfc_hidlimpl")

elif [[ "$ANDROID_VERSION" = "R" && "$PROJECT" = "PN8xT" && "$VARIANT" = "RoW" ]]
then
        gitbranch="br_ar_11_pn8xt_row_dev"

        repoList=()
        repoList+=("nxp_nci_hal_nfc")
        repoList+=("nxp_nci_hal_libnfc-nci")
        repoList+=("nxp_nci_hal_base")
        repoList+=("nfcandroid_secureelement")
        repoList+=("nfcandroid_se_hidlimpl")
        repoList+=("nfcandroid_platform")
        repoList+=("nfcandroid_nfc_hidlimpl")
        repoList+=("nfcandroid_wiredse")
        repoList+=("nxp_ese_clients")
        repoList+=("nfcandroid_frameworks")
	repoList+=("nfcandroid_hidlintf_se")

elif [[ "$ANDROID_VERSION" = "R" && "$PROJECT" = "SN220AR11" && "$VARIANT" = "GEN" ]]
then
        gitbranch="br_ar_11_comm_base_dev"

        repoList=()
        repoList+=("nxp_nci_hal_nfc")
        repoList+=("nxp_nci_hal_libnfc-nci")
        repoList+=("nxp_nci_hal_base")
        repoList+=("nfcandroid_secureelement")
        repoList+=("nfcandroid_se_hidlimpl")
        repoList+=("nfcandroid_platform")
        repoList+=("nfcandroid_nfc_hidlimpl")
        repoList+=("nfcandroid_wiredse")
        repoList+=("nxp_ese_clients")
        repoList+=("nfcandroid_frameworks")
        repoList+=("nfcandroid_nxp_libs")

elif [[ "$ANDROID_VERSION" = "12" && "$PROJECT" = "SN220" && "$VARIANT" = "GEN" ]]
then
        gitbranch="br_ar_12_comm_base_dev"

        repoList=()
        repoList+=("nxp_nci_hal_nfc")
        repoList+=("nxp_nci_hal_libnfc-nci")
        repoList+=("nxp_nci_hal_base")
        repoList+=("nfcandroid_secureelement")
        repoList+=("nfcandroid_se_hidlimpl")
        repoList+=("nfcandroid_platform")
        repoList+=("nfcandroid_nfc_hidlimpl")
        repoList+=("nfcandroid_wiredse")
        repoList+=("nxp_ese_clients")
        repoList+=("nfcandroid_frameworks")
        repoList+=("nfcandroid_nxp_libs")
	repoList+=("nfcandroid_keymaster_hidlimpl")
	repoList+=("nfcandroid_weaver_hidlimpl")

elif [[ "$ANDROID_VERSION" = "12" && "$PROJECT" = "SN1xx" && "$CID" = "RoW" ]]
then

        gitbranch="br_ar_12_comm_base_dev"

        repoList=()
        repoList+=("nxp_nci_hal_nfc")
        repoList+=("nxp_nci_hal_libnfc-nci")
        repoList+=("nxp_nci_hal_base")
        repoList+=("nxp_ese_clients")
        repoList+=("nfcandroid_wiredse")
        repoList+=("nfcandroid_nxp_libs")
        repoList+=("nfcandroid_frameworks")
        repoList+=("nfcandroid_secureelement")
        repoList+=("nfcandroid_se_hidlimpl")
        repoList+=("nfcandroid_platform")
        repoList+=("nfcandroid_nfc_hidlimpl")
        repoList+=("nfcandroid_keymaster_hidlimpl")
        repoList+=("nfcandroid_weaver_hidlimpl")

else
	echo "Your Input doesnot match any of the existing combination"

fi
}


create_mw_dir(){
	if [[ ! -d $MW_PATH  ]]; 
	then
        mkdir -p $MW_PATH || die "Error with $MW_PATH dir creation"
  
	else
		rm -rf $MW_PATH/* || die "Error while doing content cleanup under $MW_PATH"
	fi
}

changelist_gen(){
	
	echo "CHANGE LIST FOR -  $PROJECT $VARIANT $ANDROID_VERSION "
	echo "Cloning all repo's listed under branch - $gitbranch for generation of changelist"
	for repo2clone in ${repoList[*]}
	do
		cd $MW_PATH || die "Error while trying to switch to $MW_PATH"
		git clone ssh://"$USER_ID"@www.collabnet.nxp.com:29418/"$repo2clone" || die "Issue with repo clone $repo2clone"
		cd $MW_PATH/$repo2clone || die "Error while trying to switch to repository - $repo2clone"
		git checkout $gitbranch || die "Error while trying to switch to branch - $gitbranch on the repo - $repo2clone"
		echo "Successfully checked out branch - $gitbranch on the repo - $repo2clone"
		git pull || die "Error while trying to pull latest code"
		git log --pretty=oneline $OLD_MW_TAG..$NEW_MW_TAG | cut  -f2- -d" " | tee -a $MW_PATH/tmp.txt
	done
	
	echo "Checking if any other repository is listed under different branch / master..."
	
	if [ ${#repoListMaster[@]} -eq 0 ]
	then
		echo "No repo's listed under Master for this Job, ignoring..."
	else
		echo "Cloning all repo's listed under branch - master"
		for repo2clone in ${repoListMaster[*]}
		do
			cd $MW_PATH || die "Error while trying to switch to $MW_PATH"
			git clone ssh://"$USER_ID"@www.collabnet.nxp.com:29418/"$repo2clone" || die "Issue with repo clone $repo2clone"
			cd $MW_PATH/$repo2clone || die "Error while trying to switch to repository - $repo2clone"
			git checkout master || die "Error while trying to switch to Master branch on $repo2clone"
			echo "Already on the Branch - Master, now proceeding to apply tag"
			git log --pretty=oneline $OLD_MW_TAG..$NEW_MW_TAG | cut  -f2- -d" " | tee -a $MW_PATH/tmp.txt
		done
	fi

	if [ ${#repoListBranch2[@]} -eq 0 ] 
	then
		echo "No repo's listed under other branch category for this Job"
	else
		echo "Cloning all repo's listed under branch -$gitbranch2"
		for repo2clone in ${repoListBranch2[*]}
		do
			cd $MW_PATH || die "Error while trying to switch to $MW_PATH"
			git clone ssh://"$USER_ID"@www.collabnet.nxp.com:29418/"$repo2clone" || die "Issue with repo clone $repo2clone"
			cd $MW_PATH/$repo2clone || die "Error while trying to switch to repository - $repo2clone"
			git checkout $gitbranch2 || die "Error while trying to switch to branch - $gitbranch2 on the repo - $repo2clone"
			echo "Successfully checked out branch - $gitbranch2 on the repo - $repo2clone"
			git log --pretty=oneline $OLD_MW_TAG..$NEW_MW_TAG | cut  -f2- -d" " | tee -a $MW_PATH/tmp.txt
		done
	fi

	
	sed -i '/Merge /d' $MW_PATH/tmp.txt
	sed -i '/Revert /d' $MW_PATH/tmp.txt
	#sed -i -e 's/\[PT_artf/\[artf]/g' $MW_PATH/tmp.txt
	sed -i -e 's/^\[/ /g' $MW_PATH/tmp.txt
	sed -i -e 's/\]/-> /g' $MW_PATH/tmp.txt
	sed -i -e 's/\[//g' $MW_PATH/tmp.txt
	sed -i -e 's/://g' $MW_PATH/tmp.txt
	#sed -i -e 's/ //g' $MW_PATH/tmp.txt

	cat $MW_PATH/tmp.txt | cut -d"-" -f 1 > $MW_PATH/tmp1.txt
	cat $MW_PATH/tmp1.txt | sort | uniq > $MW_PATH/tmp2.txt

	sed -i '1i ID' $MW_PATH/tmp2.txt

	if [[ -f $MW_PATH/*.csv  ]]
	then
		echo "deleting previous csv file\n"
		rm -rf $MW_PATH/*.csv
	fi

	cp $MW_PATH/tmp2.txt $MW_PATH/$NEW_MW_TAG.csv
	
	cp $MW_PATH/$NEW_MW_TAG.csv $WORKSPACE/


	rm -rf $MW_PATH/tmp.txt $MW_PATH/tmp1.txt
	
	
	echo "Successfully generated the change list between $OLD_MW_TAG and $NEW_MW_TAG"
	
}

printDetail(){

	echo "Android Verion: $ANDROID_VERSION" >> $WORKSPACE/EnvironmentDetails.csv
	echo "Project: $PROJECT on Branch: $gitbranch" >> $WORKSPACE/EnvironmentDetails.csv
	echo "old MW Tag: $OLD_MW_TAG" >> $WORKSPACE/EnvironmentDetails.csv
	echo "New MW Tag: $NEW_MW_TAG" >> $WORKSPACE/EnvironmentDetails.csv
	echo "Repo List:" >> $WORKSPACE/EnvironmentDetails.csv
	for repo2clone in ${repoList[*]}
	do
		echo $repo2clone >> $WORKSPACE/EnvironmentDetails.csv
	done

	for repo2clone in ${repoListMaster[*]}
	do
		echo $repo2clone >> $WORKSPACE/EnvironmentDetails.csv
	done


}

main(){

repo_choice
create_mw_dir
changelist_gen
printDetail

}
main

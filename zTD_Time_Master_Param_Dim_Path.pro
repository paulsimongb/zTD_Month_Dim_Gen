﻿601,100
602,"zTD_Time_Master_Param_Dim_Path"
562,"NULL"
586,
585,
564,
565,"izQh<A]Dpa>sYhcWQyG>U<b`mm@jYNqBVcgppcC:\DYBgSm`h:EFC1jX1GmTLb_\BHyEpD\]gOvrSWDJARhMAu;A@1<>20\[\spY6uqmsNDuEK`uRHoHTf0P>X;2_J:vT9CiZSSjI=n9ld^NPrcFgwk?s[KT:jPiBKalOv^gz]7hN9uPuG9AR=qdl[lOC9f\Rz?oEJp="
559,1
928,0
593,
594,
595,
597,
598,
596,
800,
801,
566,0
567,","
588,"."
589,","
568,""""
570,
571,
569,0
592,0
599,1000
560,4
pDimPrefix
pUnprefixedDim
pElemPrefix
pPath
561,4
2
2
2
2
590,4
pDimPrefix,"B_"
pUnprefixedDim,"Effective_Mth"
pElemPrefix,"E_"
pPath,"E:\Dropbox\TM1\zTD_Dev\ImportData\"
637,4
pDimPrefix,"Dimension Prefix"
pUnprefixedDim,"Dimension Prefix"
pElemPrefix,"Dimension Prefix"
pPath,"Folder Path relative to the Server where the CSV files were generated by the spreadsheet."
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,231

#****Begin: Generated Statements***
#****End: Generated Statements****

vThisPro = 'zTD_Time_Master_Param_Dim_Path' ;

# Copyright Success Cubed Ltd 2008-2020

# This should be called from the zTD_Month_Dim_Gen spreadsheet
# once the required time dimension files have been generated
# There is an action button to run this on the sheet.

# This is the Master process that orchestrates everything necessary
# to setup and update a Time Dim, including all its Named Hierarchies
# and subsets, structure, aliases, and attributes

# It calls various sub-processes to achieve this.

# It is assumed that this process will be run 
# by a TM1 Adminsitrator.
# It is not intended for use by an end-user as
# a time dimension will typically be key to the 
# operation of a TM1 system.

# NON-STANDARD CUT DOWN ERROR HANDLING
# This process does not use the full set of zTD
# process initialisation and error handling routines

# ###############################################

# Session Variables

NumericSessionVariable('svError') ;

svError = 0 ;

# ###############################################

# Constants

gvInfoCube = 'zTD_Info' ; 

# ###############################################

# Validate Parameters

# #################################

vDimPrefix = pDimPrefix ;
vUnprefixedDim = pUnprefixedDim ;
vElemPrefix = pElemPrefix ;

IF( vUnprefixedDim  @= ''  ) ;
  vMsg = 'The Unprefixed Dim Name cannot be blank' ;
  svError = 1 ;
  ItemReject( vMsg ) ;
ENDIF ;

# #################################

vPath = pPath ;

IF( vPath @= '' ) ;
  svError = 1 ;
  vMsg = 'Path cannot be blank' ; 
  ItemReject( vMsg ) ;
ENDIF ;

# #################################

vDim = vDimPrefix | vUnprefixedDim ;

# #################################

vPro = 'zTD_Time_Setup_Dim_Param_DimPrefix_UnprefixedDim_ElemPrefix_Path' ;

vRet = ExecuteProcess( vPro ,
                                            'pDimPrefix' , vDimPrefix , 
                                            'pUnprefixedDim' , vUnprefixedDim , 
                                            'pElemPrefix' , vElemPrefix ,
                                            'pPath' , vPath  ) ;

IF( vRet <> ProcessExitNormal() ) ;
  svError = 1 ;
  vMsg = 'Error running process ' | vPro | 
                ' for Dim ' | vDim ;
                ' using CSV files in Path ' | vPath ;
  ItemReject( vMsg ) ;
ENDIF ;

# #################################

vPro = 'zTD_Time_Upd_Dim_and_Named_Hier_Structure_Param_Dim_Path' ;

vRet = ExecuteProcess( vPro ,
                                            'pDim' , vDim , 
                                            'pPath' , vPath  ) ;

IF( vRet <> ProcessExitNormal() ) ;
  svError = 1 ;
  vMsg = 'Error running process ' | vPro | 
                ' for Dim ' | vDim ;
                ' using CSV files in Path ' | vPath ;
  ItemReject( vMsg ) ;
ENDIF ;

# #################################

vPro = 'zTD_Time_Load_Alias_Param_Dim_Path' ; 

vRet = ExecuteProcess( vPro ,
                                            'pDim' , vDim , 
                                            'pPath' , vPath  ) ;

IF( vRet <> ProcessExitNormal() ) ;
  svError = 1 ;
  vMsg = 'Error running process ' | vPro | 
                ' for Dim ' | vDim ;
                ' using CSV files in Path ' | vPath ;
  ItemReject( vMsg ) ;
ENDIF ;

# #################################

vPro = 'zTD_Time_Load_Attr_Param_Dim_Path' ; 

vRet = ExecuteProcess( vPro ,
                                            'pDim' , vDim , 
                                            'pPath' , vPath  ) ;

IF( vRet <> ProcessExitNormal() ) ;
  svError = 1 ;
  vMsg = 'Error running process ' | vPro | 
                ' for Dim ' | vDim ;
                ' using CSV files in Path ' | vPath ;
  ItemReject( vMsg ) ;
ENDIF ;

# #################################

# Call process to put description attribute into consol levels
# the CalMthName has already been used to populate the base level

vPro = 'zTD_Time_Load_Description_Alias_Param_Dim_Hier' ; 

# We need to call this for each Hierarchy

# Check that the dim exists

vHierListDim = '}Hierarchies_' | vDim ;

IF( DimensionExists( vHierListDim ) = 1 ) ; 

  vHierNum = 0 ; 
  vNumHiers = DIMSIZ( vHierListDim ) ; 
  WHILE( vHierNum < vNumHiers ) ; 
    vHierNum  = vHierNum + 1 ;
    vDimHier = DIMNM( vHierListDim , vHierNum ) ;
    vColonPos = SCAN( ':' , vDimHier ) ;
    IF( vColonPos = 0 ) ;
     # Assume Classic Hier
      vHier = vDim ;
    ELSE ;
     vHier = subst( vDimHier , vColonPos + 1 , 255 ) ;
    ENDIF ;

    vRet = ExecuteProcess( vPro , 
                               'pDim' , vDim , 
                               'pHier' , vHier ) ; 
    IF( vRet <> ProcessExitNormal() ) ;
      svError = 1 ;
      vMsg = 'Error running process ' | vPro | 
                    ' for Dim ' | vDim ;
                    ' and Hier ' | vHier ;
      ItemReject( vMsg ) ;
    ENDIF ;

  END ;

ENDIF ;

# #################################

# All Aliases and Attributes will be in now
# Create a Default Subset on the }ElementAttributes dimension

vElemAttrDim = '}ElementAttributes_' | vDim ;

vSub = 'Default' ; 

IF( SubsetExists( vElemAttrDim, vSub ) = 0 ) ;
  SubsetCreate( vElemAttrDim , vSub ) ;
ENDIF ;

vMDX = '{ TM1SORT( { TM1SubsetAll( [' | vElemAttrDim | '] ) } , ASC ) }' ; 

HierarchySubsetMDXSet( vElemAttrDim , vElemAttrDim , vSub , vMDX ) ;

# #################################

# This part is only run if the system is using
# full zTD
# It updates all Subsets and Aliases
# to reflect the current period

IF( CubeExists( gvInfoCube ) = 1 & CubeExists( 'zTD_Info_Month_Fin' ) = 1 ) ;

  vPostMthDim = CellGetS( gvInfoCube , 'Any' , 'Posting Mth Dim' ) ; 
  vEffMthDim   = CellGetS( gvInfoCube , 'Any' , 'Effective Mth Dim' ) ; 

  IF( vDim @= vPostMthDim % vDim @= vEffMthDim ) ;

    vPro = 'zTD_Sub_Attr_Chg_Sub_Alias_After_Chg_Per_Param_Dim' ;

    vRet = ExecuteProcess( vPro ,
                                                'pDim' , vDim  ) ;

    IF( vRet <> ProcessExitNormal() ) ;
      svError = 1 ;
      vMsg = 'Error running process ' | vPro | 
                    ' for Dim ' | vDim ;
      ItemReject( vMsg ) ;
    ENDIF ;

  ENDIF ;

ENDIF ;

# ############################################


573,3

#****Begin: Generated Statements***
#****End: Generated Statements****
574,3

#****Begin: Generated Statements***
#****End: Generated Statements****
575,40

#****Begin: Generated Statements***
#****End: Generated Statements****


# NON-STANDARD CUT DOWN ERROR HANDLING

# SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS

# EPILOG START  (after any CubeSetLogChanges)

# ##################################################

# Trap for rejects due to eg inability to convert a string to number 
# or some other such file formatting issue.

IF( GetProcessErrorFileName() @<> '' & svError <> 1 ) ;
  svError = 1 ;
  vMsg = 'One or more lines were rejected, ' | 
          'possibly due to formatting issues in the source data. ' | 
           'Please check error detail for more information. ' | 
            'If there is not a link for this on the screen use ' |
             'Application Folder \zTD_End User\300 Get Error Detail\' ;
  ItemReject( vMsg ) ;
ENDIF ;

IF( svError = 1 ) ;

  # Raise an error

  ProcessQuit ;

ENDIF ;

# ##################################################

# SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS



576,CubeAction=1511DataAction=1503CubeLogChanges=0
930,0
638,1
804,0
1217,0
900,
901,
902,
938,0
937,
936,
935,
934,
932,0
933,0
903,
906,
929,
907,
908,
904,0
905,0
909,0
911,
912,
913,
914,
915,
916,
917,0
918,1
919,0
920,50000
921,""
922,""
923,0
924,""
925,""
926,""
927,""

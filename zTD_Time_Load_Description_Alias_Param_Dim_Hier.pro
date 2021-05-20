601,100
602,"zTD_Time_Load_Description_Alias_Param_Dim_Hier"
562,"SUBSET"
586,"}Dimensions"
585,"}Dimensions"
564,
565,"ynA85\BhYWBGwAZ<8i1t]5b\9a3Uxye^ND0jht:nSn1qvnd5A:Sh:w3I1Op3HPiXfXu;:Sw@pJAfTd40JxAnMpIKdwNVi@3kSR4:44>nOnOgw8;6FYuO?YcpXCB8]eB;g?Kb3Ej:[Grxgeich5=DEicNBjqm[8Udh0`JhD6K54`7k[?fKSxOz`eK=ykxJ5yVaQQV_hIT"
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
589,
568,""""
570,
571,All
569,0
592,0
599,1000
560,2
pDim
pHier
561,2
2
2
590,2
pDim,"N_Effective_Mth"
pHier,"N_Effective_Mth"
637,2
pDim,"Dimension"
pHier,"Hier"
577,1
vElem
578,1
2
579,1
1
580,1
0
581,1
0
582,1
VarType=32ColType=827
603,0
572,72

#****Begin: Generated Statements***
#****End: Generated Statements****

vThisPro = 'zTD_Time_Load_Description_Alias_Param_Dim_Hier' ;

# Copyright Success Cubed Ltd 2008

# This sets the Descripton Text Attribute
# This will either be the CalMthName
# or if there is no CalMthName because the
# element is a consolidation that is specific
# to a financial year, then it will be the element name
# In both cases the description will not have the 
# prefixing eg E_CL_ or E_F4_

# ###############################################

# Session Variables

NumericSessionVariable('svError') ;

svError = 0 ;

# ###############################################

# Standard Variables

vDataRecCount = 0 ; 
vMetaDataRecCount = 0 ; 

# ###############################################

# #################################

# Validate Parameters

# #################################

vDim = pDim ;

IF( vDim @= '' ) ;
  svError = 1 ;
  vMsg = 'Dimension name cannot be blank' ; 
  ItemReject( vMsg ) ;
ENDIF ;

IF( DimensionExists( vDim) = 0 ) ;
  svError = 1 ;
  vMsg = 'Dimension ' | vDim | ' does not exist. Run the Setup step from the spreadsheet.' ; 
  ItemReject( vMsg ) ;
ENDIF ;

vHier = pHier ; 

IF( HierarchyExists( vDim , vHier ) = 0 ) ;
  vMsg = 'For Dimension ' | vDim | ' the Hierarchy ' | vHier | ' does not exist ' ; 
  svError = 1 ;
  ItemReject( vMsg ) ;
ENDIF ;

# #################################

vDimHier = vDim | ':' | vHier ;

# #################################

# Change Data Source to All elements sub of the source dim

DataSourceNameForServer= vDimHier ;
DataSourceDimensionSubset = 'ALL' ; 

573,3

#****Begin: Generated Statements***
#****End: Generated Statements****
574,46

#****Begin: Generated Statements***
#****End: Generated Statements****

# NON-STANDARD CUT DOWN ERROR HANDLING

# SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS

# D A T A    T A B   S T A R T

IF( svError = 1 ) ;
  ProcessBreak ;
ENDIF ;

vDataRecCount = vDataRecCount + 1 ;

# SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS

# ###########################################################

# Skip base level elements as they will have had the Description attr set from the CalMthName

IF( ElementLevel( vDim , vHier , vElem ) = 0 ) ; 
  ItemSkip ;
ENDIF ;

# Trim Prefix

# This assumes that '_' has been used as a separator

# There should be at least eg a F4_ prefix but most probably eg an E_F4_ prefix
# starting from pos 3 will pick up the last underscore in the prefix in either case

vTest = subst( vElem , 3 , 255 ) ;

vPos = SCAN( '_' , vTest ) ;

IF( vPos > 0 ) ;
  vDescrip = subst( vElem , vPos + 3 , 255 ) ;
ELSE ;
  vDescrip = vElem ;
ENDIF ;

ElementAttrPutS( vDescrip , vDim , vHier , vElem , 'Description' ) ;


575,3

#****Begin: Generated Statements***
#****End: Generated Statements****
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

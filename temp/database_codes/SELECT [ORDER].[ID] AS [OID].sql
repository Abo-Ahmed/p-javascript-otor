 SELECT [ORDER].[ID] AS [OID]
--  , 
    -- (   [EJ_STMT].[EJ_AMNT] & " - " & 
    --     [TR_STMT].[TR_AMNT] & " - " & 
    --     [STP_STMT].[STP_AMNT] & " - " & 
    --     [MFR_STMT].[MFR_AMNT] & " - " & 
    --     [DSN_STMT].[DSN_AMNT] & " - " 
    -- ) AS CONTENTS

    SELECT * 
    FROM [ORDER] LEFT JOIN
    (SELECT [CONTENT].[ORDER_ID] AS EJ_ID,SUM ([CONTENT].[AMOUNT]) AS EJ_AMNT FROM [CONTENT] WHERE [CONTENT].[TYPE] = "EJAZA" GROUP BY [CONTENT].[ORDER_ID]) AS EJ_STMT  
    (SELECT [CONTENT].[ORDER_ID] AS TR_ID,SUM ([CONTENT].[AMOUNT]) AS TR_AMNT FROM [CONTENT] WHERE [CONTENT].[TYPE] = "TREE" GROUP BY [CONTENT].[ORDER_ID]) AS TR_STMT  
    (SELECT [CONTENT].[ORDER_ID] AS STP_ID,SUM ([CONTENT].[AMOUNT]) AS STP_AMNT FROM [CONTENT] WHERE [CONTENT].[TYPE] = "STAMP" GROUP BY [CONTENT].[ORDER_ID]) AS STP_STMT  
    (SELECT [CONTENT].[ORDER_ID] AS MFR_ID,SUM ([CONTENT].[AMOUNT]) AS MFR_AMNT FROM [CONTENT] WHERE [CONTENT].[TYPE] = "MFRGH" GROUP BY [CONTENT].[ORDER_ID]) AS MFR_STMT  
    LEFT JOIN (SELECT [CONTENT].[ORDER_ID] AS DSN_ID,SUM ([CONTENT].[AMOUNT]) AS DSN_AMNT FROM [CONTENT] WHERE [CONTENT].[TYPE] = "DESIGNING" GROUP BY [CONTENT].[ORDER_ID]) AS DSN_STMT 

    WHERE ( [ORDER].[ID] = [EJ_STMT].[EJ_ID] OR [EJ_STMT].[EJ_ID] IS NULL )
    AND ( [ORDER].[ID] = [STP_STMT].[STP_ID] OR [STP_STMT].[STP_ID] IS NULL )    
    -- AND ( [ORDER].[ID] = [TR_STMT].[TR_ID] OR [TR_STMT].[TR_ID] IS NULL )
    -- AND ( [ORDER].[ID] = [MFR_STMT].[MFR_ID] OR [MFR_STMT].[MFR_ID]] IS NULL )
    -- AND ( [ORDER].[ID] = [DSN_STMT].[DSN_ID] OR [DSN_STMT].[DSN_ID] IS NULL )

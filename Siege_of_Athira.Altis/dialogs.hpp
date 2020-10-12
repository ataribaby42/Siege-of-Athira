class soaDialogScore
{
	idd = 999910;
	movingenable = false;

   	class Controls
	{
		class soaDialogScoreBg: IGUIBack
		{
			idc = 2200;
			x = safezoneXAbs;
			y = safezoneY;
			w = safezoneWAbs;
			h = safezoneH;
			colorBackground[] = {0.4, 0.4, 0.4, 1};
		};
		class soaDialogTraderPcBg: RscPicture
		{
			idc = 1201;
			text = "images\survivedbg.paa";
			x = safeZoneXAbs;
			y = (safezoneY + safezoneH) - (0.056 * safezoneH * 15);
			w = 0.0364583 * safezoneW * 15;
			h = 0.056 * safezoneH * 15;
		};
		class soaDialogScoreTxTitle: RscText
		{
			idc = 1000;
			text = $STR_DialogScoreTxTitle;
			style = ST_CENTER;
			x = 0.354167 * safezoneW + safezoneX;
			y = 0.22 * safezoneH + safezoneY;
			w = 0.291667 * safezoneW;
			h = 0.042 * safezoneH;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 2);
		};
		class soaDialogScoreTxTotalScore: RscText
		{
			idc = 1001;
			style = ST_CENTER;
			x = 0.354167 * safezoneW + safezoneX;
			y = 0.29 * safezoneH + safezoneY;
			w = 0.291667 * safezoneW;
			h = 0.028 * safezoneH;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class soaDialogScoreLbScores: RscListbox
		{
			idc = 1500;
			x = 0.354167 * safezoneW + safezoneX;
			y = 0.332 * safezoneH + safezoneY;
			w = 0.291667 * safezoneW;
			h = 0.378 * safezoneH;
			colorSelect[] = 
			{
				1,
				1,
				1,
				1
			};
			colorSelect2[] = 
			{
				1,
				1,
				1,
				1
			};
			colorSelectBackground[] = 
			{
				0,
				0,
				0,
				0
			};
			colorSelectBackground2[] = 
			{
				0,
				0,
				0,
				0
			};
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.9)";
		};
		class soaDialogScoreBtClose: RscButton
		{
			idc = 1600;
			text = $STR_DialogScoreBtClose;
			x = 0.5875 * safezoneW + safezoneX;
			y = 0.7296 * safezoneH + safezoneY;
			w = 0.0583333 * safezoneW;
			h = 0.042 * safezoneH;
			action = "closeDialog 0";
		};
   	};
};

class soaDialogTrader
{
	idd = 999920;
	movingenable = false;

	class Controls
	{
		class soaDialogTraderBg: IGUIBack
		{
			idc = 2200;
			x = safezoneXAbs;
			y = safezoneY;
			w = safezoneWAbs;
			h = safezoneH;
			colorBackground[] = {0.4, 0.4, 0.4, 1};
		};
		class soaDialogTraderPcBg: RscPicture
		{
			idc = 1201;
			text = "images\traderbg.paa";
			x = safeZoneXAbs;
			y = (safezoneY + safezoneH) - (0.056 * safezoneH * 15);
			w = 0.0364583 * safezoneW * 15;
			h = 0.056 * safezoneH * 15;
		};
		class soaDialogTraderLbTraderInvetory: RscListbox
		{
			idc = 1500;
			x = 0.222917 * safezoneW + safezoneX;
			y = 0.262 * safezoneH + safezoneY;
			w = 0.145833 * safezoneW;
			h = 0.504 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class soaDialogTraderLbYourInventory: RscListbox
		{
			idc = 1501;
			x = 0.63125 * safezoneW + safezoneX;
			y = 0.262 * safezoneH + safezoneY;
			w = 0.145833 * safezoneW;
			h = 0.504 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class soaDialogTraderLbPurchase: RscListbox
		{
			idc = 1502;
			x = 0.4125 * safezoneW + safezoneX;
			y = 0.262 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.224 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class soaDialogTraderLbPayment: RscListbox
		{
			idc = 1503;
			x = 0.4125 * safezoneW + safezoneX;
			y = 0.542 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.224 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class soaDialogTraderTxPayment: RscText
		{
			idc = 1000;
			text = $STR_DialogTraderPayment;
			x = 0.4125 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.028 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class soaDialogTraderTxPurchase: RscText
		{
			idc = 1001;
			text = $STR_DialogTraderPurchase;
			x = 0.4125 * safezoneW + safezoneX;
			y = 0.22 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.028 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class soaDialogTraderTxTrader: RscText
		{
			idc = 1002;
			text = $STR_DialogTraderTrader;
			x = 0.222917 * safezoneW + safezoneX;
			y = 0.22 * safezoneH + safezoneY;
			w = 0.145833 * safezoneW;
			h = 0.028 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class soaDialogTraderTxYourInventory: RscText
		{
			idc = 1003;
			text = $STR_DialogTraderYourInventory;
			x = 0.63125 * safezoneW + safezoneX;
			y = 0.22 * safezoneH + safezoneY;
			w = 0.145833 * safezoneW;
			h = 0.028 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class soaDialogTraderBtClose: RscButton
		{
			idc = 1600;
			text = $STR_DialogTraderClose;
			x = 0.682292 * safezoneW + safezoneX;
			y = 0.78 * safezoneH + safezoneY;
			w = 0.0947917 * safezoneW;
			h = 0.056 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			action = "closeDialog 0";
		};
		class soaDialogTraderBtDeal: RscButton
		{
			idc = 1601;
			text = $STR_DialogTraderDeal;
			x = 0.45625 * safezoneW + safezoneX;
			y = 0.78 * safezoneH + safezoneY;
			w = 0.13125 * safezoneW;
			h = 0.056 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class soaDialogTraderPcMood: RscPicture
		{
			idc = 1200;
			text = "images\sad.paa";
			x = 0.4125 * safezoneW + safezoneX;
			y = 0.78 * safezoneH + safezoneY;
			w = 0.0364583 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class soaDialogTraderTxTitle: RscText
		{
			idc = 1004;
			text = $STR_DialogTraderTitle;
			x = 0.215625 * safezoneW + safezoneX;
			y = 0.164 * safezoneH + safezoneY;
			w = 0.56875 * safezoneW;
			h = 0.056 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5)";
		};
		class soaDialogTraderBtPurchaseAdd: RscButton
		{
			idc = 1602;
			text = ">>";
			x = 0.376042 * safezoneW + safezoneX;
			y = 0.29 * safezoneH + safezoneY;
			w = 0.0291667 * safezoneW;
			h = 0.042 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class soaDialogTraderBtPurchaseRemove: RscButton
		{
			idc = 1603;
			text = "<<";
			x = 0.376042 * safezoneW + safezoneX;
			y = 0.416 * safezoneH + safezoneY;
			w = 0.0291667 * safezoneW;
			h = 0.042 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class soaDialogTraderBtPaymentAdd: RscButton
		{
			idc = 1604;
			text = "<<";
			x = 0.594792 * safezoneW + safezoneX;
			y = 0.57 * safezoneH + safezoneY;
			w = 0.0291667 * safezoneW;
			h = 0.042 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class soaDialogTraderBtPaymentRemove: RscButton
		{
			idc = 1605;
			text = ">>";
			x = 0.594792 * safezoneW + safezoneX;
			y = 0.696 * safezoneH + safezoneY;
			w = 0.0291667 * safezoneW;
			h = 0.042 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class soaDialogTraderTxChat: RscStructuredText
		{
			idc = 1100;
			text = ""; 
			x = 0.266647 * safezoneW + safezoneX;
			y = 0.1 * safezoneH + safezoneY;
			w = 0.466705 * safezoneW;
			h = 0.8 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
	};
};
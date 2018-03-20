if OBJECT_ID('tbTipoAtraso') is not null
drop table tbTipoAtraso; 

if OBJECT_ID('tbPagos') is not null
drop table tbPagos;

create table tbTipoAtraso(fiIdTipoAtraso int identity(1,1) primary key,
						fcTipoAtraso varchar(300),
						fiTipoAtrasoDiaIni int,
						fiTipoAtrasoDiaFin int);

create table tbPagos(fiIdPago int identity(1,1) primary key,
					fdFechaPago datetime,
					fdFechaRealPago datetime)

declare @fecIni datetime = '20170101',
	@fecfin datetime;

while (GETDATE()>=@fecini)
begin		
	set @fecfin = case when day(@fecIni) in (6, 8, 10, 18)
						then dateadd(dd, 80, @fecIni)
					when day(@fecIni) in (1,5,9)
						then dateadd(dd, 96, @fecIni)
					when day(@fecIni) in (27, 20)
						then dateadd(dd, 150, @fecIni)
					else dateadd(dd, 30, @fecIni)
				end;

	insert tbPagos(fdFechaPago, fdFechaRealPago) values(@fecIni, @fecfin);
	set @fecIni = DATEADD(DD, 1,@fecIni);
end

insert tbTipoAtraso(fcTipoAtraso, fiTipoAtrasoDiaIni,fiTipoAtrasoDiaFin)values('CarteraVencida1', 30, 60);
insert tbTipoAtraso(fcTipoAtraso, fiTipoAtrasoDiaIni,fiTipoAtrasoDiaFin)values('CarteraVencida1', 61, 90);
insert tbTipoAtraso(fcTipoAtraso, fiTipoAtrasoDiaIni,fiTipoAtrasoDiaFin)values('CarteraVencida1', 91, 120);
insert tbTipoAtraso(fcTipoAtraso, fiTipoAtrasoDiaIni,fiTipoAtrasoDiaFin)values('CarteraVencida1', 121, 360);

select DATEDIFF(DAY, fdFechaPago, fdFechaRealPago) diferencia, * 
from tbPagos a
inner join tbTipoAtraso b
on DATEDIFF(DAY, fdFechaPago, fdFechaRealPago) between fiTipoAtrasoDiaIni and fiTipoAtrasoDiaFin
order by 2;
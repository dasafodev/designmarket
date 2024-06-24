import 'package:desigmarket/features/stocks/cubit/stocks_cubit.dart';
import 'package:desigmarket/features/stocks/models/company_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddToWishlistForm extends StatefulWidget {
  const AddToWishlistForm({
    super.key,
    required this.cubitContext,
  });

  final BuildContext cubitContext;

  @override
  State<AddToWishlistForm> createState() => _AddToWishlistFormState();
}

class _AddToWishlistFormState extends State<AddToWishlistForm> {
  TextEditingController alertPriceController = TextEditingController();
  String? selectedCompanySymbol;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BlocBuilder<StocksCubit, StocksState>(
        bloc: widget.cubitContext.read(),
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              const Text(
                'Add Company',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: selectedCompanySymbol,
                  hint: const Text('Select Company'),
                  items: state.companies.map((Company company) {
                    return DropdownMenuItem<String>(
                      value: company.ticker,
                      child: Text(company.name),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCompanySymbol = newValue!;
                    });
                    // selectedCompanySymbol = newValue;
                  },
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: alertPriceController,
                decoration: const InputDecoration(
                  label: Text('Alert Price'),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: ElevatedButton(
                  onPressed: () {
                    if (selectedCompanySymbol != null &&
                        alertPriceController.text.isNotEmpty) {
                      widget.cubitContext
                          .read<StocksCubit>()
                          .addCompanyToWatchlist(selectedCompanySymbol!,
                              double.parse(alertPriceController.text));
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Add to watchlist'),
                ),
              ),
              const SizedBox(height: 16),
            ],
          );
        },
      ),
    );
  }
}

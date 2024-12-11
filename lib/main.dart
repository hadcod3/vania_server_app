
import 'route/customer_routes.dart';
import 'route/product_routes.dart';
import 'route/order_routes.dart';
import 'route/vendor_routes.dart';
import 'route/orderitems_routes.dart';
import 'route/productnote_routes.dart';

void main() {
  final app = Vania();

  // Register routes
  customerRoutes(app);
  productRoutes(app);
  orderRoutes(app);
  vendorRoutes(app);
  orderItemsRoutes(app);
  productNotesRoutes(app);

  // Start server
  app.listen('127.0.0.1', 8080, () {
    print('Server is running on http://127.0.0.1:8080');
  });
}
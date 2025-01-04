import 'package:shared/imports.dart';

void appShowModal({
  required BuildContext context,
  required Widget child,
}) {
  showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(24.0),
      ),
    ),
    isScrollControlled: true,
    context: context,
    barrierColor: Colors.transparent,
    backgroundColor: Colors.white,
    builder: (BuildContext ctx) => BottomSheet(
      backgroundColor: Colors.white,
      enableDrag: true,
      elevation: 2,
      onClosing: () {},
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.9,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24.0),
        ),
      ),
      builder: (context) => DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(24.0),
          ),
          boxShadow: [
            BoxShadow(
              color:
                  Theme.of(context).colorScheme.onBackground.withOpacity(0.3),
              blurRadius: 30,
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 40),
          child: Column(
            children: [
              SizedBox(
                width: 47,
                height: 7,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(23),
                    color: const Color(0xffE6E6E6),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(child: child),
            ],
          ),
        ),
      ),
    ),
  );
}

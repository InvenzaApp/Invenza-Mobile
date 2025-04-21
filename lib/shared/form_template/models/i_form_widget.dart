import 'package:flutter/material.dart';

abstract class IFormWidget extends Widget {
  const IFormWidget({super.key});
}

abstract class IFormStatelessWidget extends StatelessWidget
    implements IFormWidget {
  const IFormStatelessWidget({super.key});
}

abstract class IFormStatefulWidget extends StatefulWidget
    implements IFormWidget {
  const IFormStatefulWidget({super.key});
}
